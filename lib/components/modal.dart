import 'package:flutter/material.dart';

class CCDialog extends StatelessWidget {
  const CCDialog({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'How important is this issue?',
        style: TextStyle(fontSize: 14),
      ),
      content: SingleChildScrollView(
        child: child,
      ),
      alignment: Alignment.center,
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'))
      ],
    );
  }
}
