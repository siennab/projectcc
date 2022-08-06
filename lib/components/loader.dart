import 'package:flutter/material.dart';

class CCLoader extends StatelessWidget {
  const CCLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
