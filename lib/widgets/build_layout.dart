import 'package:flutter/material.dart';

class BuildLayout extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;

  const BuildLayout({super.key, required this.desktop, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 700) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
