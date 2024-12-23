import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  TextEditingController textFieldController;
  String labelText;
  String ?errorText;
  bool obscureText;
  CommonTextField(
      {required this.textFieldController,
        required this.labelText,
        required this.errorText,
        required this.obscureText,
        super.key});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textFieldController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        border: const OutlineInputBorder(),
      ),
      obscureText: widget.obscureText,
    );
  }
}
