import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_cc/services/user_service.dart';

class CCAppBar extends StatelessWidget implements PreferredSizeWidget {
  CCAppBar({this.automaticallyImplyLeading = true, Key? key}) : super();
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize {
    return new Size.fromHeight(40.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: [
        IconButton(
            onPressed: () {
              UserService().logout().then(
                (value) {
                  Navigator.of(context).pushNamed('/');
                },
              );
            },
            icon: Icon(Icons.logout, size: 16))
      ],
    );
  }
}
