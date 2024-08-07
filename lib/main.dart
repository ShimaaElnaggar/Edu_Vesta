import 'dart:ui';

import 'package:edu_vesta/services/preferences_services.dart';
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/views/Home/home_view.dart';
import 'package:edu_vesta/views/On%20Boarding/on_boarding_view.dart';
import 'package:edu_vesta/views/Splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesServices.initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: ' Edu Vesta ',
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.primary),
        scaffoldBackgroundColor: ColorUtility.scaffoldBackground,
      ),
      onGenerateRoute: (settings) {
        final String routeName = settings.name ?? '';
        //final Map? data = settings.arguments as Map?;
        switch (routeName) {
          case OnBoardingView.id:
            return MaterialPageRoute(
                builder: (context) => const OnBoardingView());
          case HomeView.id:
            return MaterialPageRoute(builder: (context) => const HomeView());
          default:
            return MaterialPageRoute(builder: (context) => const SplashView());
        }
      },
      initialRoute: SplashView.id,
    );
  }
}

class _CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
