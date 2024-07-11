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
  void initState() {
    super.initState();
    widget.postController.init();
  }

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
            return Center(
              child: Column(
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshPosts,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
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
            );
          }

          return const Center(child: Text('No posts available'));
        },
      ),
    );
  }

  Future<void> _refreshPosts() async => setState(() {});
}
