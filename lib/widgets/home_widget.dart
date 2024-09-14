import 'package:edu_vesta/views/Courses/top_courses_view.dart';
import 'package:edu_vesta/widgets/cart_Icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/preferences_services.dart';
import '../utils/color_utility.dart';
import '../views/Categories/categories_view.dart';
import '../views/Courses/best_seller_courses_view.dart';
import 'categories_widget.dart';
import 'courses_widget.dart';
import 'label_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _greetingMessage = '';
  String _userName = '';
  @override
  void initState() {
    super.initState();
    _loadGreetingMessage();
  }

  Future<void> _loadGreetingMessage() async {
    String userAction =
        await PreferencesServices.prefs!.getString('userAction') ?? '';
    _userName = FirebaseAuth.instance.currentUser?.displayName ?? "";

    if (userAction == 'login') {
      _saveGreetingMessage('Welcome back ');
    } else if (userAction == 'signUp') {
      _saveGreetingMessage('Welcome ');
    } else {
      _saveGreetingMessage('Welcome ');
    }
  }

  void _saveGreetingMessage(String message) {
    setState(() {
      _greetingMessage = message;
    });
  }

  String getGreetingMessage() {
    return _greetingMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: getGreetingMessage(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      TextSpan(
                          text: _userName,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorUtility.primary)),
                    ],
                  ),
                ),
                const CartIcon(),
              ],
            ),
            LabelWidget(
              name: 'Categories',
              onSeeAllClicked: () {
                Navigator.pushNamed(context, CategoriesView.id);
              },
            ),
            const CategoriesWidget(),
            const SizedBox(
              height: 20,
            ),
            LabelWidget(
              name: 'Top Courses',
              onSeeAllClicked: () {
                Navigator.pushNamed(context, TopCoursesView.id);
              },
            ),
            CoursesWidget(
              rankValue: 'top_rated',
              limitCourses: true,
            ),
            const SizedBox(
              height: 20,
            ),
            LabelWidget(
              name: 'Best Seller',
              onSeeAllClicked: () {
                Navigator.pushNamed(context, BestSellerCoursesView.id);
              },
            ),
            CoursesWidget(
              rankValue: 'best_seller',
              limitCourses: true,
            ),
          ],
        ),
      ),
    );
  }
}
