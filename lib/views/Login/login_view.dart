import 'package:edu_vesta/views/Home/home_view.dart';
import 'package:edu_vesta/widgets/auth/auth_templete_widget.dart';
import 'package:edu_vesta/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        try {
          var credentials =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          if (credentials.user != null) {
            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You Logged In Successfully'),
              ),
            );

            Navigator.pushReplacementNamed(context, HomeView.id);
          }
        } on FirebaseAuthException catch (e) {
          if (!context.mounted) return;
          if (e.code == 'user-not-found') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No user found for that email.'),
              ),
            );
          } else if (e.code == 'wrong-password') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wrong password provided for that user.'),
              ),
            );
          } else if (e.code == 'user-disabled') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User Disabled'),
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Credential'),
              ),
            );
          }
        } catch (e) {
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
            ),
          );
        }
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
