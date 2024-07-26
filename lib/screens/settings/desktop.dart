import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/screens/auth/bloc/auth_bloc.dart';
import 'package:web_app/styles/text_styles.dart';
import 'package:web_app/widgets/confirmation_dialog.dart';
import 'package:web_app/widgets/err_snackbar.dart';

class SettingsScreenDesktop extends StatelessWidget {
  const SettingsScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuth) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else if (state is AuthLoggedOut) {
          Navigator.of(context).pop();
          context.go('/authScreen');
        } else if (state is ErrorState) {
          Navigator.of(context).pop();
          showErrorSnackbar(context, state.err);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: txtMed,
              ),
              const SizedBox(height: 20),
              SizedBox(
                // constraints: const BoxConstraints(maxWidth: 60),
                width: 300,
                child: ListTile(
                  onTap: () async => showCustomConfirmationDialog(context),
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
