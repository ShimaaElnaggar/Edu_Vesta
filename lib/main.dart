import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/views/Splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Edu Vesta ',
      theme: ThemeData(
        fontFamily:'PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.primary),
        scaffoldBackgroundColor: ColorUtility.scaffoldBackground,
        ),

      home: const SplashView(),
    );
  }
}




