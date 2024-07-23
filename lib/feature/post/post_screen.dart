import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/models/updates.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/post_controller.dart';
import 'package:flutter_tg_mini_app_overview/feature/post/widgets/refresh_button.dart';

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
        title: const Text('Updates'),
      ),
      body: FutureBuilder<List<Updates>>(
        future: widget.postController.fetchUpdates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataIsEmpty = snapshot.hasData && snapshot.data!.isEmpty;
          if (snapshot.hasError || dataIsEmpty) {
            Widget textWidget = Text('Error: ${snapshot.error}');
            if (dataIsEmpty) {
              textWidget = const Text('No messages yet');
            }

            return Center(
              child: Column(
                children: [
                  textWidget,
                  const SizedBox(height: 16),
                  RefreshButton(onTap: _refreshPosts),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            final itemCount = snapshot.data!.length;

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                physics: const BouncingScrollPhysics(),
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];

                      Widget itemWidget = ListTile(
                        title: Text(item.text),
                        subtitle: Text(item.chatName),
                      );

                      if (index == itemCount - 1) {
                        itemWidget = Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: itemWidget,
                        );
                      }

                      return itemWidget;
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    child: RefreshButton(
                      onTap: _refreshPosts,
                      buttonColor: widget.postController.telegram.themeParams.buttonColor,
                      textColor: widget.postController.telegram.themeParams.buttonTextColor,
                    ),
                  ),
                ],
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
