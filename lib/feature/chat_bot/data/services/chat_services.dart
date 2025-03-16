import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class ChatServices {
  Future<String?> chatWithGemini(String message);
  void startChattingSession();
  Future<String?> sendMessage(String message, File? image);
}

class ChatBotServicesImpl implements ChatServices {
  late final GenerativeModel model;

  ChatBotServicesImpl() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception('GEMINI_API_KEY is not found in .env file');
    }
    model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
  }

  late ChatSession _chatSession;

  @override
  Future<String?> chatWithGemini(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text;
  }

  @override
  void startChattingSession() {
    _chatSession = model.startChat();
  }

  @override
  Future<String?> sendMessage(String message, [File? image]) async {
    late final Content content;
    if (image != null) {
      final bytes = await image.readAsBytes();
      content = Content.multi([
        TextPart(message),
        DataPart('image/jpeg', bytes),
      ]);
    } else {
      content = Content.text(message);
    }

    final response = await _chatSession.sendMessage(content);
    return response.text;
  }
}
