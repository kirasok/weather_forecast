import 'package:flutter/material.dart';

class AppbarIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const AppbarIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      splashRadius: 20,
    );
  }
}
