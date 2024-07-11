import 'package:flutter/material.dart';

class TgMiniApp extends StatelessWidget {
  const TgMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}