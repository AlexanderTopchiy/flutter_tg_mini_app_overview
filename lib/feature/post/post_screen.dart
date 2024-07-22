import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/message.dart';
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
        title: const Text('Messages'),
      ),
      body: FutureBuilder<List<Message>>(
        future: widget.postController.fetchMessages(),
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
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No messages yet'),
              );
            }
            
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
                    title: Text(item.messageText),
                    subtitle: Text('${item.timestamp}'),
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
