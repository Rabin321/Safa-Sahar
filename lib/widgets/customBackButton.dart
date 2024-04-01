import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';
import 'package:flutter/material.dart';

class CustomBackIcon extends StatelessWidget {
  final Color color;
  final void Function()? onPressed;

  const CustomBackIcon(
      {Key? key, this.color = Colors.white, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onPressed);
  }
}
