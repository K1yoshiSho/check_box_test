import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final bool isOutline;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isOutline,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        backgroundColor: MaterialStateColor.resolveWith((states) => isOutline ? Colors.grey : Colors.deepPurple),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: isOutline ? Colors.deepPurple : Colors.white,
        ),
      ),
    );
  }
}