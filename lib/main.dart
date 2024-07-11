import 'package:flutter/material.dart';
import 'package:flutter_tg_mini_app_overview/tg_mini_app.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

void main() async {
  await _tgNotLoadedWorkaround();
  
  runApp(const TgMiniApp());
}

// This is the hack from the package docs - https://pub.dev/packages/telegram_web_app#how-to-use
Future<void> _tgNotLoadedWorkaround() async {
  try {
    if (TelegramWebApp.instance.isSupported) {
      await TelegramWebApp.instance.ready();
      Future.delayed(
        const Duration(seconds: 1),
        TelegramWebApp.instance.expand,
      );
    }
  } catch (error) {
    debugPrint('Error happened in Flutter while loading Telegram $error');
    // Add delay for 'Telegram not loading sometimes' bug
    await Future.delayed(const Duration(milliseconds: 200));
    main();
    
    return;
  }
}
