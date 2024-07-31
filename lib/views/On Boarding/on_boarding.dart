import 'package:edu_vesta/models/on_board.dart';
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/views/Home/home_view.dart';
import 'package:edu_vesta/widgets/dots_indicator.dart';
import 'package:edu_vesta/widgets/on_board_arrows.dart';
import 'package:edu_vesta/widgets/on_boarding_content.dart';
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
          body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff3A3A3A)),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView.builder(
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
          //const SizedBox(height: 40,),
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
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OnBoardArrows(
                  onPressed: () {
                    if (pageIndex > 0) {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  icon: Icons.arrow_back,
                  color: pageIndex == 0 ? Colors.grey : ColorUtility.secondary,
                ),
                OnBoardArrows(
                  onPressed: () {
                    if (pageIndex < demoData.length - 1) {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  icon: Icons.arrow_forward,
                  color: pageIndex == demoData.length - 1
                      ? Colors.grey
                      : ColorUtility.secondary,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 70,
          ),
        ]),
      )),
    );
  }
}
