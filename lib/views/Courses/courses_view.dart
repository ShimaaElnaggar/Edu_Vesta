
import 'package:edu_vesta/utils/image_utility.dart';
import 'package:edu_vesta/widgets/courses_headers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../utils/color_utility.dart';

import '../../widgets/cart_Icon.dart';

class CoursesView extends StatefulWidget {

  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  bool showCourses = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: ScreenUtil().screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40),
                    Text(
                      'Courses',
                      style: TextStyle(
                          color: ColorUtility.midBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    CartIcon(),
                  ],
                ),
                const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showCourses = !showCourses;
                      });
                    },
                    child: Container(
                      height: 37,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: ColorUtility.lightGrey,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'All',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  showCourses? CoursesHeadersWidget()
                      : Center(child: Image.asset(ImageUtility.frame, width: 250, height: 350)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
