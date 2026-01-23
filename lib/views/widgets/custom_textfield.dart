import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final TextInputType? textInputType;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    required this.isPassword,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: (isPassword)?true:false,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}