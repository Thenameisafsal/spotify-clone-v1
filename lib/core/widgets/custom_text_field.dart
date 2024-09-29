import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool ObscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.controller,
      this.ObscureText = false,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
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
