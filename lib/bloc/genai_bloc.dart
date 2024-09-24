import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:public_chat/data/chat_content.dart';
import 'package:public_chat/utils/bloc_extensions.dart';
import '../repository/genai_model.dart';

part 'genai_event.dart';
part 'genai_state.dart';

class GenaiBloc extends Bloc<GenaiEvent, GenaiState> {
  final List<ChatContent> _content = [];
  final GenaiModel _model = GenaiModel();

  GenaiBloc() : super(GenaiInitial()) {
    on<SendMessageEvent>(_sendmessage);
  }
  void _sendmessage(SendMessageEvent event, Emitter<GenaiState> emit) async {
    _content.add(ChatContent.user(event.message));
    emitSafely(MessageUpdate(List.from(_content)));

    try {
      final response = await _model.sendMessage([Content.text(event.message)]);
      final String? text = response.text;

      // Thêm phản hồi từ AI vào luồng và cập nhật lại
      if (text == null) {
        _content.add(ChatContent.gemini('Unable to generate response'));
      } else {
        _content.add(ChatContent.gemini(text));
      }
      // _streamController.sink.add(_content); // Đảm bảo cập nhật luồng tại đây
      // _scrollToBottom(); // xử lý xuống cuối khi mess mới
    } catch (e) {
      _content.add(ChatContent.gemini("Unspected fail"));
    }

    emitSafely(MessageUpdate(List.from(_content)));
  }
}
