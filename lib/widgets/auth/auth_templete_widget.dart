import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/utils/image_utility.dart';
import 'package:edu_vesta/views/Login/login_view.dart';
import 'package:edu_vesta/views/Sign%20UP/sign_up_view.dart';
import 'package:edu_vesta/widgets/custom_elevated_button.dart';
import 'package:edu_vesta/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

import '../../views/Login/reset_password_view.dart';

class AuthTemplateWidget extends StatefulWidget {
  final Future<void> Function()? onLogin;
  final Future<void> Function()? onSignUp;
  final Widget body;
  AuthTemplateWidget(
      {this.onLogin, this.onSignUp, required this.body, super.key}) {
    assert(onLogin != null || onSignUp != null,
        'onLogin or onSignUp should not be null');
  }

  @override
  State<AuthTemplateWidget> createState() => _AuthTemplateWidgetState();
}

class _AuthTemplateWidgetState extends State<AuthTemplateWidget> {
  EdgeInsetsGeometry get _padding =>
      const EdgeInsets.symmetric(vertical: 20, horizontal: 20);

  bool get isLogin => widget.onLogin != null;

  String get title => isLogin ? "Login" : "Sign Up";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: _padding
            .subtract(const EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: ColorUtility.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Or sign with',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: ColorUtility.grey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                        horizontal: 0,
                        backgroundColor: const Color(0xff1877f2),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.facebook,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Sign In With Facebook',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {}),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomElevatedButton(
                    horizontal: 0,
                    backgroundColor: Colors.white,
                    onPressed: () {

                    },
                    child: Image.asset(
                      ImageUtility.google,
                      width: 30,
                      height: 30,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin
                      ? 'Don\'t have an account?'
                      : 'Already have an account',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomTextButton(
                  label: isLogin ? 'Sign Up' : 'Login',
                  textStyle: const TextStyle(
                      color: ColorUtility.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      isLogin ? SignUpView.id : LoginView.id,
                    );
                  },
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: Padding(
              padding: _padding,
              child: SingleChildScrollView(
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.body,
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            label: isLogin ? 'Forget Password ?' : '',
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: ColorUtility.secondary,
                              fontWeight: FontWeight.w500
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context,ResetPasswordView.id);
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            backgroundColor: ColorUtility.secondary,
                            onPressed: () async {
                              if (isLogin) {
                                setState(() {
                                  _isLoading = true;
                                });
                                await widget.onLogin?.call();
                                setState(() {
                                  _isLoading = false;
                                });
                              } else {
                                setState(() {
                                  _isLoading = true;
                                });
                                await widget.onSignUp?.call();
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    title,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
