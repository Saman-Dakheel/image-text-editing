import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  VoidCallback onPressed;
  Widget child;
  Color textColor;
  Color color;

  DefaultButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color,
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: textColor,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
