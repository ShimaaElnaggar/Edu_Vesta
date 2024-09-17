import 'package:edu_vesta/views/profile/profile_view.dart';
import 'package:flutter/material.dart';

import '../../services/preferences_services.dart';
import '../../utils/color_utility.dart';

import '../../widgets/home_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Chats/chats_view.dart';
import '../Courses/courses_view.dart';
import '../Search/search_view.dart';

class HomeView extends StatefulWidget {
  static const id = 'Home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  static List<Widget> widgetsOptions = [
    HomeWidget(),
    CoursesView(),
    SearchView(),
    ChatsView(),
    ProfileView(),
  ];
  void onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  late String profileImageUrl;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() {
      profileImageUrl = FirebaseAuth.instance.currentUser?.photoURL ?? '';
      profileImageUrl =
          PreferencesServices.prefs?.getString('profileImageUrl') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Stack(
          children: [
            BottomNavigationBar(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              currentIndex: selectedIndex,
              onTap: onItemSelected,
              selectedItemColor: ColorUtility.secondary,
              unselectedItemColor: ColorUtility.primary,
              type: BottomNavigationBarType.shifting,
              items: [
                const BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: '',
                  icon: Icon(
                    Icons.home,
                    size: 20,
                  ),
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/courses.png',
                      height: 20,
                      width: 20,
                      color: selectedIndex == 1
                          ? ColorUtility.secondary
                          : ColorUtility.primary,
                    ),
                    backgroundColor: Colors.white,
                    label: ''),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      size: 20,
                    ),
                    backgroundColor: Colors.white,
                    label: ''),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                    ),
                    backgroundColor: Colors.white,
                    label: ''),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      radius: 12,
                      backgroundColor: ColorUtility.secondary,
                      backgroundImage: profileImageUrl.isNotEmpty
                          ? NetworkImage(profileImageUrl)
                          : const NetworkImage(
                              'https://th.bing.com/th/id/OIP.sUtuDAldRIExk4haK9HB1AAAAA?rs=1&pid=ImgDetMain',
                            ),
                    ),
                    backgroundColor: Colors.white,
                    label: ''),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 14,
                    color: index == selectedIndex
                        ? ColorUtility.secondary
                        : Colors.transparent,
                  );
                }),
              ),
            ),
          ],
        ),
        body: widgetsOptions.elementAt(selectedIndex),
      ),
    );
  }
}
