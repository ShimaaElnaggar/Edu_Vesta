import 'package:edu_vesta/models/on_board.dart';
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/widgets/custom_elveted_button.dart';
import 'package:edu_vesta/widgets/dots_indicator.dart';
import 'package:edu_vesta/widgets/on_board_arrows.dart';
import 'package:edu_vesta/widgets/on_boarding_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int pageIndex = 0;
  late PageController pageController;
  //late Timer timer;
  final List<OnBoard> demoData = [
    OnBoard(
        image: 'assets/images/badges.png',
        title: ' Certification and Badges',
        description: "Earn a certificate after completion of \n every course."),
    OnBoard(
      image: 'assets/images/progress_tracking.png',
      title: ' Progress Tracking',
      description: 'Check your Progress of every course.',
    ),
    OnBoard(
      image: 'assets/images/offline_access.png',
      title: ' Offline Access',
      description: 'Make your course available offline.',
    ),
    OnBoard(
      image: 'assets/images/course_catalog.png',
      title: ' Course Catalog',
      description: 'View in which courses you are enrolled.',
    ),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    // timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    //   if (pageIndex < demoData.length - 1) {
    //     pageController.nextPage(
    //       duration: const Duration(milliseconds: 300),
    //       curve: Curves.ease,
    //     );
    //   } else {
    //     timer.cancel();
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    //timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              pageIndex == demoData.length - 1
                  ? TextButton(
                      onPressed: () {
                        pageController.jumpToPage(demoData.length - 2);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        pageController.jumpToPage(demoData.length - 1);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        kIsWeb
            ? const SizedBox(
                height: 37,
              )
            : const SizedBox(
                height: 50,
              ),
        Expanded(
          flex: 3,
          child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              itemCount: demoData.length,
              itemBuilder: (context, index) {
                return OnBoardingContent(
                  image: demoData[index].image,
                  title: demoData[index].title,
                  description: demoData[index].description,
                );
              }),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Center(
                      child: DotsIndicator(
                        isActive: index == pageIndex,
                      ),
                    ),
                  ),
                ],
              ),
              kIsWeb
                  ? const SizedBox(
                      height: 30,
                    )
                  : const SizedBox(
                      height: 70,
                    ),
              getButtons,
            ],
          ),
        ),
      ])),
    );
  }

  Widget get getButtons => pageIndex == demoData.length - 1
      ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: CustomElevatedButton(
            onPressed: () {},
            title: 'Register',
            fixedSize: const Size(double.maxFinite, 50),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (pageIndex == 0 || pageIndex == demoData.length - 1)
                  ? const Text('')
                  : OnBoardArrows(
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      icon: Icons.arrow_back,
                      color: ColorUtility.grey,
                    ),
              (pageIndex < demoData.length - 1)
                  ? OnBoardArrows(
                      onPressed: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      icon: Icons.arrow_forward,
                      color: ColorUtility.secondary,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
}
