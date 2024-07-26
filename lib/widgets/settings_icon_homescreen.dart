import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KSettingInHomeScreen extends StatelessWidget {
  const KSettingInHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
          onPressed: () => GoRouter.of(context).go('/settingsScreen'),
          icon: const Icon(Icons.settings)),
    );
  }
}
