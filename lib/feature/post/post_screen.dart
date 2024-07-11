import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/post.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/post_controller.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    required this.postController,
    super.key,
  });

  final PostController postController;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: widget.postController.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                physics: const BouncingScrollPhysics(),
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: RefreshIndicator(
                onRefresh: _refreshPosts,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];

                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.body),
                    );
                  },
                ),
              ),
            );
          }

          return const Center(child: Text('No posts available'));
        },
      ),
    );
  }

  Future<void> _refreshPosts() async => setState(() {});
}
