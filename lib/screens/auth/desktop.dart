import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/functions/auth_validators.dart';
import 'package:web_app/screens/auth/bloc/auth_bloc.dart';
import 'package:web_app/styles/text_styles.dart';
import 'package:web_app/widgets/auth_text_field.dart';
import 'package:web_app/widgets/login_btn.dart';
import 'package:web_app/widgets/toggle_singin_text.dart';

class AuthDesktop extends StatefulWidget {
  const AuthDesktop({super.key});

  @override
  AuthDesktopState createState() => AuthDesktopState();
}

class AuthDesktopState extends State<AuthDesktop> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        child: Form(
          key: _formKey,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is LoadingAuth) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AuthSignUp) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Started,',
                      style: txtLarge,
                    ),
                    Center(child: _buildSignUp(context)),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back,',
                      style: txtLarge,
                    ),
                    Center(child: _buildLogIn(context)),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300.0, // Set your maximum width here
      ),
      padding: EdgeInsets.only(top: size.height * 0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextField(
            textEditingController: _nameController,
            hintText: 'Name',
            validator: validateName,
            obscureText: false,
          ),
          const SizedBox(height: 16),
          AuthTextField(
            textEditingController: _emailController,
            hintText: 'Email',
            validator: validateEmail,
            obscureText: false,
          ),
          const SizedBox(height: 16), // Space between fields

          AuthTextField(
            textEditingController: _passwordController,
            hintText: 'Password',
            validator: validatePassword,
            obscureText: true,
          ),
          const SizedBox(height: 10), // Space between fields

          ToggleSignInMethodText(
              onTap: () => context
                  .read<AuthBloc>()
                  .add(ToggleSignUpAndLogIn(signUp: false)),
              firstText: 'Got an account? ',
              secondText: 'Log In'),
          const SizedBox(height: 100), // Space between fields

          Center(
            child: CustomButton(
              text: 'Sign Up',
              onPressed: () {
                final formState = _formKey.currentState;
                if (formState != null && formState.validate()) {
                  context.read<AuthBloc>().add(SignUpEvent(
                      context: context,
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogIn(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300.0, // Set your maximum width here
      ),
      padding: EdgeInsets.symmetric(vertical: size.height * 0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          AuthTextField(
            textEditingController: _emailController,
            hintText: 'Email',
            validator: validateEmail,
            obscureText: false,
          ),
          const SizedBox(height: 16), // Space between fields

          AuthTextField(
            textEditingController: _passwordController,
            hintText: 'Password',
            validator: validatePassword,
            obscureText: true,
          ),
          const SizedBox(height: 10), // Space between fields

          ToggleSignInMethodText(
              onTap: () => context
                  .read<AuthBloc>()
                  .add(ToggleSignUpAndLogIn(signUp: true)),
              firstText: 'New User? ',
              secondText: 'Sign Up'),

          const SizedBox(height: 100), // Space between fields

          Center(
            child: CustomButton(
              text: 'Log In',
              onPressed: () {
                final formState = _formKey.currentState;
                if (formState != null && formState.validate()) {
                  context.read<AuthBloc>().add(LogInEvent(
                      context: context,
                      email: _emailController.text,
                      password: _passwordController.text));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
