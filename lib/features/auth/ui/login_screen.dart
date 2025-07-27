import 'package:final_project/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/helpers/app_regex.dart';
import '../logic/auth/auth_cubit.dart';
import 'forgot_password_page.dart';
import 'widgets/app_header.dart';
import 'widgets/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.onRegisterTap});
  final VoidCallback? onRegisterTap;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    final String email = authCubit.emailController.text;
    final String password = authCubit.passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      AppHeader(
                        icon: Icons.shopping_bag,
                        title: 'welcome_back'.tr(),
                        subtitle: 'sign_in_to_continue'.tr(),
                      ),
                      MyTextField(
                        controller: context.read<AuthCubit>().emailController,
                        hintText: "email".tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please_enter_email".tr();
                          }
                          if (!AppRegex.isEmailValid(value)) {
                            return 'please_enter_valid_name'.tr();
                          }
                          return null;
                        },
                      ),
                      MyTextField(
                        controller:
                            context.read<AuthCubit>().passwordController,
                        hintText: "password".tr(),
                        obscureText:
                            context.watch<AuthCubit>().loginPasswordObsecure,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please_enter_password".tr();
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => context.push(ForgotPasswordPage()),
                              child: Text(
                                "forgot_password".tr(),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            login(context);
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
                              "login".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.primary,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "or_continue_with".tr(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.primary,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await context.read<AuthCubit>().signInWithGoogle();
                          },
                          icon: Image.asset(
                            'assets/images/google.png',
                            width: 20,
                            height: 20,
                          ),
                          label: Text(
                            'continue_with_google'.tr(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            "dont_have_account".tr(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          GestureDetector(
                            onTap: onRegisterTap,
                            child: Text(
                              "register_now".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 13),
                            ),
                          ),
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
