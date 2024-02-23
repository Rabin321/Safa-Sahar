import 'package:flutter/material.dart';
import '../components/constants.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    required this.buttonName,
    required this.onPressed, // Added onPressed callback
    required this.bgColor,
    required this.textColor,
    this.controller,
  });

  final String buttonName;
  final VoidCallback onPressed; // onPressed callback
  final Color bgColor;
  final Color textColor;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.black12,
          ),
        ),
        onPressed: onPressed, // Assigning the onPressed callback
        child: Text(
          buttonName,
          style: kButtonText.copyWith(color: textColor),
        ),
      ),
    );
  }
}
