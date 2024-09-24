import 'package:google_generative_ai/google_generative_ai.dart';

class GenaiModel {
  late final GenerativeModel _model;

  GenaiModel() {
    const apiKey = "AIzaSyBp3JPa1Z2exxj08nIn_7-EfFUWali85ss";
    apiKey == null
        ? print('GenAi - oh ohhh!!!')
        : print('GenAi - Hello world!');

    _model = GenerativeModel(model: 'gemini-1.0-pro', apiKey: apiKey);
    // _model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  }

  Future<GenerateContentResponse> sendMessage(List<Content> content) =>
      _model.generateContent(content);
}
