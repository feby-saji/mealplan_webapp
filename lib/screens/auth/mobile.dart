import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/functions/auth_validators.dart';
import 'package:web_app/screens/auth/bloc/auth_bloc.dart';
import 'package:web_app/styles/text_styles.dart';
import 'package:web_app/widgets/auth_text_field.dart';
import 'package:web_app/widgets/login_btn.dart';
import 'package:web_app/widgets/toggle_singin_text.dart';

class AuthMobile extends StatefulWidget {
  const AuthMobile({super.key});

  @override
  _AuthMobileState createState() => _AuthMobileState();
}

class _AuthMobileState extends State<AuthMobile> {
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
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is LoadingAuth) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AuthSignUp) {
                return _buildSignUp(context);
              }
              return _buildLogIn(context);
            },
          ),
        ),
      ),
    );
  }

  Column _buildSignUp(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get Started,',
          style: txtLarge,
        ),
        const Spacer(),
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
        const SizedBox(height: 16),
        AuthTextField(
          textEditingController: _passwordController,
          hintText: 'Password',
          validator: validatePassword,
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ToggleSignInMethodText(
          onTap: () =>
              context.read<AuthBloc>().add(ToggleSignUpAndLogIn(signUp: false)),
          firstText: 'Got an account? ',
          secondText: 'Log In',
        ),
        const SizedBox(height: 50),
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
                      password: _passwordController.text,
                    ));
              }
            },
          ),
        ),
        const SizedBox(height: 200),
      ],
    );
  }

  Column _buildLogIn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back,',
          style: txtLarge,
        ),
        const Spacer(),
        AuthTextField(
          textEditingController: _emailController,
          hintText: 'Email',
          validator: validateEmail,
          obscureText: false,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          textEditingController: _passwordController,
          hintText: 'Password',
          validator: validatePassword,
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ToggleSignInMethodText(
          onTap: () =>
              context.read<AuthBloc>().add(ToggleSignUpAndLogIn(signUp: true)),
          firstText: 'New User? ',
          secondText: 'Sign Up',
        ),
        const SizedBox(height: 50),
        Center(
          child: CustomButton(
            text: 'Login',
            onPressed: () {
              final formState = _formKey.currentState;
              if (formState != null && formState.validate()) {
                context.read<AuthBloc>().add(LogInEvent(
                      context: context,
                      email: _emailController.text,
                      password: _passwordController.text,
                    ));
              }
            },
          ),
        ),
        const SizedBox(height: 200),
      ],
    );
  }
}
