import 'package:flutter/material.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/post_controller.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/post_screen.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class TgMiniApp extends StatelessWidget {
  const TgMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Mini App using Flutter',
      theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),
      home: PostScreen(
        postController: PostController(
          telegram: TelegramWebApp.instance,
        ),
      ),
    );
  }
}
