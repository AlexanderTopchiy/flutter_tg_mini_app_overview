import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    required this.onTap,
    this.buttonColor,
    this.textColor,
    super.key,
  });

  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
      ),
      child: const Text('Refresh'),
    );
  }
}
