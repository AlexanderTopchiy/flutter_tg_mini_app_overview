import 'package:flutter_tg_mini_app_overview/feature/post/models/updates.dart';

class Post implements Updates {
  @override
  final String text;
  @override
  final String chatName;

  const Post({
    required this.text,
    required this.chatName,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final post = json['channel_post'];
    return Post(
      text: post['text'] ?? '',
      chatName: post['chat']['title'] ?? '',
    );
  }
}
