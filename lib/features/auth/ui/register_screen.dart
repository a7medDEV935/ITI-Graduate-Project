import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/app_regex.dart';
import '../logic/auth/auth_cubit.dart';
import '../logic/auth/auth_state.dart';
import 'widgets/app_header.dart';
import 'widgets/my_textfield.dart';
import 'widgets/password_validations.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key, required this.onLoginTap});

  final VoidCallback? onLoginTap;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool allPasswordRulesPassed(AuthState state) {
    return state is PasswordValidationsState &&
        state.hasLowercase &&
        state.hasUppercase &&
        state.hasSpecialCharacters &&
        state.hasNumber &&
        state.hasMinLength;
  }

  void register(BuildContext context) async {
    final authCubit = context.read<AuthCubit>();
    final String name = context.read<AuthCubit>().nameController.text;
    final String email = context.read<AuthCubit>().emailController.text;
    final String password = context.read<AuthCubit>().passwordController.text;
    final String confirmPassword =
        context.read<AuthCubit>().confirmPasswordController.text;
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        await authCubit.register(name, email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final canRegister = allPasswordRulesPassed(context.read<AuthCubit>().state);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      const AppHeader(
                        icon: Icons.person_add,
                        title: 'Create Account',
                        subtitle: 'Sign up to get started',
                      ),
                      MyTextField(
                        controller: context.read<AuthCubit>().nameController,
                        hintText: "Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please Enter valid Name';
                          }
                          return null;
                        },
                      ),
                      MyTextField(
                        controller: context.read<AuthCubit>().emailController,
                        hintText: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!AppRegex.isEmailValid(value)) {
                            return 'please Enter valid Name';
                          }
                          return null;
                        },
                      ),
                      MyTextField(
                        controller:
                            context.read<AuthCubit>().passwordController,
                        hintText: "password",
                        obscureText:
                            context.watch<AuthCubit>().loginPasswordObsecure,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your password";
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context)
                                .toggleLoginPasswordObsecure();
                          },
                          child: Icon(
                            context.watch<AuthCubit>().loginPasswordObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      MyTextField(
                        controller:
                            context.read<AuthCubit>().confirmPasswordController,
                        hintText: "Confirm Password",
                        obscureText: context
                            .watch<AuthCubit>()
                            .registerPasswordConfirmationObsecure,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (value !=
                              context
                                  .read<AuthCubit>()
                                  .passwordController
                                  .text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context)
                                .toggleRegisterPasswordConfirmationObsecure();
                          },
                          child: Icon(
                            context
                                    .watch<AuthCubit>()
                                    .registerPasswordConfirmationObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final isFormValid = formKey.currentState!.validate();
                          if (isFormValid && canRegister) {
                            register(context);
                          }
                          if (!isFormValid) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Please fill all fields correctly"),
                              ),
                            );
                          } else if (!canRegister) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Password does not meet requirements"),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PasswordValidations(
                        hasLowerCase: context.watch<AuthCubit>().hasLowercase,
                        hasUpperCase: context.watch<AuthCubit>().hasUppercase,
                        hasSpecialCharacters:
                            context.watch<AuthCubit>().hasSpecialCharacters,
                        hasNumber: context.watch<AuthCubit>().hasNumber,
                        hasMinLength: context.watch<AuthCubit>().hasMinLength,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            "Already have an account",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          GestureDetector(
                            onTap: onLoginTap,
                            child: Text(
                              "Login now",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
