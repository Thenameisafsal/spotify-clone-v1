import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool ObscureText;
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.controller,
      this.ObscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      obscureText: ObscureText,
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$val si missing!";
        }
        return null;
      },
    );
  }
}
