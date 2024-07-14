import 'dart:async';

import 'package:google_generative_ai/google_generative_ai.dart';

class GenAiWorker {
  late final GenerativeModel _model;

  final List<ChatContent> _content = [];
  final StreamController<List<ChatContent>> _streamController =
      StreamController.broadcast();
  Stream<List<ChatContent>> get stream => _streamController.stream;

  GenAiWorker() {
    const apiKey = String.fromEnvironment('apiKey');
    apiKey == null
        ? print('GenAi - oh ohhh!!!')
        : print('GenAi - Hello world!');

    _model = GenerativeModel(model: 'gemini-1.0-pro', apiKey: apiKey);
  }

  void sendToGemini(String message) async {
    // Thêm tin nhắn của người dùng và cập nhật luồng
    _content.add(ChatContent.user(message));
    _streamController.sink.add(_content);
    try {
      // Gửi tin nhắn đến AI và chờ phản hồi
      final response = await _model.generateContent([Content.text(message)]);
      final String? text = response.text;

      // Thêm phản hồi từ AI vào luồng và cập nhật lại
      if (text == null) {
        _content.add(ChatContent.gemini('Unable to generate response'));
      } else {
        _content.add(ChatContent.gemini(text));
      }
      _streamController.sink.add(_content); // Đảm bảo cập nhật luồng tại đây
    } catch (e) {
      print(e);
      _content.add(ChatContent.gemini('Unable to generate response'));
      _streamController.sink.add(_content); // Cập nhật luồng khi có lỗi
    }
    ;
  }
}

enum Sender { user, gemini }

class ChatContent {
  final Sender sender;
  final String message;

  ChatContent.user(this.message) : sender = Sender.user;
  ChatContent.gemini(this.message) : sender = Sender.gemini;
}
