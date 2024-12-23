import 'package:flutter/material.dart';

class ElevatedButtonCommon extends StatefulWidget {
  Color buttonColor;
  Function() onTap;
  String buttonText;
  ElevatedButtonCommon(
      {super.key,
        required this.buttonColor,
        required this.onTap,
        required this.buttonText});

  @override
  State<ElevatedButtonCommon> createState() => _ElevatedButtonCommonState();
}

class _ElevatedButtonCommonState extends State<ElevatedButtonCommon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
      child: Text(
        widget.buttonText,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "brandaRegular",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
