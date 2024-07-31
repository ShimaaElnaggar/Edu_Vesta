import 'package:edu_vesta/views/On%20Boarding/on_boarding.dart';
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
        ),

      home: const OnBoarding(),
    );
  }
}




