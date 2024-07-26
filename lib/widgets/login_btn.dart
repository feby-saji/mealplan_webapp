import 'package:flutter/material.dart';
import 'package:web_app/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 32.0), // Padding
        elevation: 5, // Shadow depth
        textStyle: const TextStyle(
          fontSize: 16, // Text size
          fontWeight: FontWeight.bold, // Text weight
        ),
      ),
      child: Text(
        text,
        style: txtSmall,
      ),
    );
  }
}
