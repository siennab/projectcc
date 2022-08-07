import 'package:flutter/material.dart';

class CCFullSizeDialog extends StatelessWidget {
  const CCFullSizeDialog({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.background,
        child: child,
      ),
    );
  }
}
