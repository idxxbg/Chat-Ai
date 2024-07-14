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

    _model = GenerativeModel(model: 'Gemini 1.5 Pro', apiKey: apiKey);
  }

  void sendToGemini(String message) async {
    try {
      _content.add(ChatContent.user(message));
      _streamController.sink.add(_content);
      final response = await _model.generateContent([Content.text(message)]);

      final String? text = response.text;

      text == null
          ? _content.add(ChatContent.gemini('Unable to generate response'))
          : _content.add(ChatContent.gemini(text));

      // _model.generateContent({Content.text((message))});
    } catch (e) {
      print(e);
      _content.add(ChatContent.gemini('Unable to generate response'));
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
