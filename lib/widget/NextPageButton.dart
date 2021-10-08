import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Size size;

  const NextPageButton({Key? key, required this.onPressed, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: size.height * 0.05,
      bottom: size.height * 0.05,
      right: size.width * 0.1,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text('Next'),
      ),
    );
  }
}
