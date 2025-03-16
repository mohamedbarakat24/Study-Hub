import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/feature/chat_bot/data/models/message_model.dart';
import 'package:study_hub/feature/chat_bot/data/services/chat_services.dart';
import 'package:study_hub/feature/chat_bot/data/services/native_services.dart';
part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());

  final chatServices = ChatBotServicesImpl();
  final List<MessageModel> _chatMessages = [];
  final NativeServices nativeServices = NativeServices();
  File? selectedImage;

  // start chatting session
  void startChattingSession() {
    chatServices.startChattingSession();
  }

  // send message
  void sendMessage(String message) async {
    emit(SendingMessage());
    try {
      _chatMessages.add(
        MessageModel(
          message: message.trim(),
          isUser: true,
          image: selectedImage,
          time: DateTime.now().toString(),
        ),
      );
      emit(ChatBotLoaded(_chatMessages));
      final response = await chatServices.sendMessage(message, selectedImage);
      _chatMessages.add(
        MessageModel(
          message: response.toString().trim(),
          isUser: false,
          time: DateTime.now().toString(),
        ),
      );
      emit(MessageSent(_chatMessages.last));
      emit(ChatBotLoaded(_chatMessages));
    } catch (e) {
      emit(MessageSentError(e.toString()));
    }
  }

  // pickup image from camera or gallery
  void pickImage(bool isCamera) async {
    try {
      late var returnedImage;
      if (isCamera) {
        returnedImage = await nativeServices.pickImage();
      } else {
        returnedImage = await nativeServices.pickImageFromGallery();
      }
      if (returnedImage != null) {
        selectedImage = returnedImage;
        emit(PickedImageSucces(returnedImage));
      } else {
        emit(PickedImageError("Error while picking the image"));
      }
    } catch (e) {
      emit(PickedImageError(e.toString()));
    }
    return null;
  }

  // delete Pickedup image
  void deletePickedUpImage() {
    selectedImage = null;
    emit(DeletePickedUpImage());
  }
}
