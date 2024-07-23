import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/models/message.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/models/updates.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:telegram_web_app/telegram_web_app.dart';

class PostController {
  const PostController({
    required this.telegram,
  });

  final TelegramWebApp telegram;

  Future<void> init() async {
    print('Bot API version: ${telegram.version}');
    await telegram.ready();

    await _disableClosingSwipe();
    await _expandAppInitially();
  }

  Future<List<Updates>> fetchUpdates() async {
    try {
      final tgBotToken = dotenv.env['TG_BOT_TOKEN'];
      final response = await http.get(Uri.parse('https://api.telegram.org/bot$tgBotToken/getUpdates'));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final updates = jsonBody['result'] as List;

        if (updates.isEmpty) {
          return [];
        }

        final messages = updates //
            .where((x) => x.containsKey('message')) //
            .toList() //
            .map((y) => Message.fromJson(y)) //
            .toList();

        final posts = updates //
            .where((x) => x.containsKey('channel_post')) //
            .toList() //
            .map((y) => Post.fromJson(y)) //
            .toList();

        final updatesList = <Updates>[...messages, ...posts];

        return updatesList;
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (error) {
      throw Exception('Failed to load messages: $error');
    }
  }

  Future<void> _disableClosingSwipe() async {
    print('isVerticalSwipesEnabled - before: ${telegram.isVerticalSwipesEnabled}');
    if (telegram.isVerticalSwipesEnabled) {
      // Without disabling it, page scroll may has conflicts with swipe-to-close-tma gesture
      await telegram.disableVerticalSwipes();
      print('isVerticalSwipesEnabled - after: ${telegram.isVerticalSwipesEnabled}');
    }
  }

  Future<void> _expandAppInitially() async {
    print('isExpanded - before: ${telegram.isExpanded}');
    if (!telegram.isExpanded) {
      // Expand app initially
      await telegram.expand();
      print('isExpanded - after: ${telegram.isExpanded}');
    }
  }
}
