import 'package:edu_vesta/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field.dart';

class ConfirmPasswordView extends StatefulWidget {
  const ConfirmPasswordView({super.key});

  @override
  State<ConfirmPasswordView> createState() => _ConfirmPasswordViewState();
}

class _ConfirmPasswordViewState extends State<ConfirmPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 200,
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const CustomTextFormField(
                    hint: '***********',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextFormField(
                    hint: '***********',
                    label: 'Confirm Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    onPressed: () {},
                    title: 'SUBMIT',
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
