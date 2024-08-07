import 'package:edu_vesta/services/preferences_services.dart';
import 'package:edu_vesta/utils/image_utility.dart';
import 'package:edu_vesta/views/Home/home_view.dart';
import 'package:edu_vesta/views/On%20Boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  static const id = 'Splash';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _showOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageUtility.logo,
              fit: BoxFit.cover,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void _showOnBoarding() async{
    await Future.delayed(const Duration(seconds: 1));
    if(mounted){
      if (PreferencesServices.isOnBoardingSeen) {
        Navigator.pushReplacementNamed(context, HomeView.id);
      }
      else {
        Navigator.pushReplacementNamed(context, OnBoardingView.id);
      }
    }
  }
}
