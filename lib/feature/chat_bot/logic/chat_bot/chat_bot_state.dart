part of 'chat_bot_cubit.dart';

sealed class ChatBotState {}

final class ChatBotInitial extends ChatBotState {}

final class ChatBotLoading extends ChatBotState {}

final class ChatBotLoaded extends ChatBotState {
  final List<MessageModel> messages;

  ChatBotLoaded(this.messages);
}

final class ChatBotError extends ChatBotState {
  final String message;

  ChatBotError(this.message);
}

final class SendingMessage extends ChatBotState {}

final class MessageSent extends ChatBotState {
  final MessageModel message;

  MessageSent(this.message);
}

final class MessageSentError extends ChatBotState {
  final String message;

  MessageSentError(this.message);
}

final class PickedImageSucces extends ChatBotState {
  final File image;
  PickedImageSucces(this.image);
}

final class PickedImageError extends ChatBotState {
  final String message;
  PickedImageError(this.message);
}

final class DeletePickedUpImage extends ChatBotState {}
