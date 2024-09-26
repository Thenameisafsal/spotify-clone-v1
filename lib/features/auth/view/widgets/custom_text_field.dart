import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  const CustomTextField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
