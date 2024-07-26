import 'package:flutter/material.dart';
import 'package:web_app/styles/text_styles.dart';

class ToggleSignInMethodText extends StatelessWidget {
  final Function() onTap;
  final String firstText;
  final String secondText;

  const ToggleSignInMethodText({
    super.key,
    required this.onTap,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
          style: txtSmall,
          TextSpan(children: [
            TextSpan(text: firstText),
            TextSpan(
                text: secondText,
                style: const TextStyle().copyWith(color: Colors.primaries[0])),
          ])),
    );
  }
}
