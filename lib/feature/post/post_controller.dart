import 'dart:convert';

import 'package:flutter_tg_mini_app_overview/feature/post/message.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tg_mini_app_overview/feature/post/post.dart';
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

  @Deprecated('Using Messages instead')
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;

        return jsonResponse.map((post) => Post.fromJson(post as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      throw Exception('Failed to load posts: $error');
    }
  }

  Future<List<Message>> fetchMessages() async {
    try {
      const tgBotToken = String.fromEnvironment('TG_BOT_TOKEN');
      final response = await http.get(Uri.parse('https://api.telegram.org/bot$tgBotToken/getUpdates'));

      if (response.statusCode == 200) {
        return Message.fromJsonList(json.decode(response.body));
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
