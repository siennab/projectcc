import 'package:flutter/material.dart';

class PCard extends StatelessWidget {
  const PCard(
      {required this.child,
      this.bottomWidget,
      this.backgroundColor,
      this.onTap,
      Key? key})
      : super(key: key);
  final Widget child;
  final Widget? bottomWidget;
  final Color? backgroundColor;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              //  height: 250,
              child: child,
            ),
            if (bottomWidget != null) ...[
              Expanded(child: Container()),
              bottomWidget!
            ],
          ],
        ),
      ),
    );
  }
}
