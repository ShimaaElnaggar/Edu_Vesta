import 'package:edu_vesta/cubit/auth_cubit.dart';
import 'package:edu_vesta/widgets/auth/auth_templete_widget.dart';
import 'package:edu_vesta/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  static const id = 'Login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplateWidget(
      onLogin: () async {
        await context.read<AuthCubit>().login(
            context: context,
            emailController: emailController,
            passwordController: passwordController);
      },
      body: Column(
        children: [
          CustomTextFormField(
            controller: emailController,
            hint: 'Demo@gmail.com',
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            controller: passwordController,
            hint: '***********',
            label: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
