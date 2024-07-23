import 'package:flutter_tg_mini_app_overview/feature/post/models/updates.dart';

class Message implements Updates {
  @override
  final String text;
  @override
  final String chatName;

  const Message({
    required this.text,
    required this.chatName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    final message = json['message'];
    return Message(
      text: message['text'] ?? '',
      chatName: message['chat']['title'] ?? '',
    );
  }
}
