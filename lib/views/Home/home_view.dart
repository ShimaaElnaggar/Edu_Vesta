import 'package:edu_vesta/widgets/categories_widget.dart';
import 'package:edu_vesta/widgets/courses_widget.dart';
import 'package:edu_vesta/widgets/label_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../utils/color_utility.dart';

class HomeView extends StatefulWidget {
  static const id = 'Home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Welcome',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800)),
                        TextSpan(
                            text:
                                FirebaseAuth.instance.currentUser?.displayName,
                            style: const TextStyle(
                                fontSize: 24, color: ColorUtility.primary)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                ],
              ),
              LabelWidget(
                name: 'Categories',
                onSeeAllClicked: () {},
              ),
              const CategoriesWidget(),
              const SizedBox(
                height: 10,
              ),
              LabelWidget(
                name: 'Top Courses',
                onSeeAllClicked: () {},
              ),
              const CoursesWidget(rankValue: 'top_rated'),
            ],
          ),
        ),
      ),
    );
  }
}
