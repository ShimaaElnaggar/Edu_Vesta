import 'package:edu_vesta/cubit/auth_cubit.dart';
import 'package:edu_vesta/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/auth/auth_templete_widget.dart';

class SignUpView extends StatefulWidget {
  static const String id = 'SignUpView';
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplateWidget(
      onSignUp: () async {
        await context.read<AuthCubit>().signUp(
            context: context,
            emailController: emailController,
            nameController: nameController,
            passwordController: passwordController);
      },
      body: Column(
        children: [
          CustomTextFormField(
            controller: nameController,
            hint: 'Shimaa Elnaggar ',
            label: 'Full Name',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: emailController,
            hint: 'Demo@gmail.com',
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: passwordController,
            hint: '***********',
            label: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: confirmPasswordController,
            hint: '***********',
            label: 'Confirm Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
