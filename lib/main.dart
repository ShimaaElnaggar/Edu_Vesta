import 'dart:ui';
import 'package:edu_vesta/cubit/auth_cubit.dart';
import 'package:edu_vesta/firebase_options.dart';
import 'package:edu_vesta/services/preferences_services.dart';
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/views/Courses/course_details_view.dart';
import 'package:edu_vesta/views/Home/home_view.dart';
import 'package:edu_vesta/views/Login/login_view.dart';
import 'package:edu_vesta/views/On%20Boarding/on_boarding_view.dart';
import 'package:edu_vesta/views/Reset%20Password/reset_password_view.dart';
import 'package:edu_vesta/views/Sign%20UP/sign_up_view.dart';
import 'package:edu_vesta/views/Splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/course_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesServices.initPreferences();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    //print('Firebase initialization failed: $e');
    return;
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (ctx) => AuthCubit()),
      BlocProvider(create: (ctx) => CourseBloc()),
    ],
    child: const MyApp(),
  ));
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
        final dynamic data = settings.arguments;
        switch (routeName) {
          case OnBoardingView.id:
            return MaterialPageRoute(
                builder: (context) => const OnBoardingView());
          case CourseDetailsView.id:
            return MaterialPageRoute(
                builder: (context) => CourseDetailsView(
                      course: data,
                    ));
          case HomeView.id:
            return MaterialPageRoute(builder: (context) => const HomeView());
          case LoginView.id:
            return MaterialPageRoute(builder: (context) => const LoginView());
          case SignUpView.id:
            return MaterialPageRoute(builder: (context) => const SignUpView());
          case ResetPasswordView.id:
            return MaterialPageRoute(
                builder: (context) => const ResetPasswordView());
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
