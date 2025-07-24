import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/auth/auth_cubit.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void clearController(BuildContext context) {
    context.read<AuthCubit>().nameController.clear();
    context.read<AuthCubit>().emailController.clear();
    context.read<AuthCubit>().passwordController.clear();
    context.read<AuthCubit>().confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    clearController(context);
    if (showLoginPage) {
      return LoginScreen(onRegisterTap: togglePages);
    } else {
      return RegisterScreen(onLoginTap: togglePages);
    }
  }
}
