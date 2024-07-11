import 'package:flutter/material.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/post_controller.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/post_screen.dart';

class TgMiniApp extends StatelessWidget {
  const TgMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Telegram Mini App using Flutter',
      home: PostScreen(
        postController: PostController(),
      ),
    );
  }
}
