import 'dart:io';

class MessageModel {
  final String message;
  final String time;
  final File? image;
  final bool isUser;

  MessageModel(
      {required this.message,
      required this.isUser,
      this.image,
      required this.time});

  MessageModel copyWith({
    String? message,
    String? time,
    File? image,
    bool? isUser,
  }) {
    return MessageModel(
      message: message ?? this.message,
      time: time ?? this.time,
      image: image ?? this.image,
      isUser: isUser ?? this.isUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'time': time,
      "image": image,
      'isUser': isUser,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      time: map['time'] as String,
      image: map['image'] as File,
      isUser: map['isUser'] as bool,
    );
  }
}
