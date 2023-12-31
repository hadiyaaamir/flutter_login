import 'package:flutter/material.dart';
import 'package:flutter_login/profile/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.profileButton = false,
  });

  final String title;
  final bool profileButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: profileButton
          ? [
              IconButton(
                onPressed: () => Navigator.push(context, ProfilePage.route()),
                icon: const Icon(Icons.account_circle, size: 30),
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
