import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String? Function(String?) validator; // Validator function type
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.validator,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        errorStyle: const TextStyle(
          color: Colors.red, // Color of the error text
          fontSize: 14, // Font size of the error text
          fontWeight: FontWeight.normal, // Font weight of the error text
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
              color: Colors.red, width: 1.5), // Error border color and width
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red,
              width: 2.0), // Error border color and width when focused
        ),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
