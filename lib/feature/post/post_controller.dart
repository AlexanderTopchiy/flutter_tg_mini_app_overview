import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_tg_mini_app_overview/feature/post/post.dart';

class PostController {
  const PostController();

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
}
