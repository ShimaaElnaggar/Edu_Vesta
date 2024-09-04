import 'package:flutter/material.dart';

import '../../utils/color_utility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/home_widget.dart';

class HomeView extends StatefulWidget {
  static const id = 'Home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> widgetsOptions = [
    HomeWidget(),
    Text(
      'Courses',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Chats',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];
  void onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Stack(
          children: [
            BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: selectedIndex,
              onTap: onItemSelected,
              selectedItemColor: ColorUtility.secondary,
              unselectedItemColor: ColorUtility.primary,
              type: BottomNavigationBarType.shifting,
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: '',
                  icon: Icon(
                    Icons.home,
                    size: 18,
                  ),
                ),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.bookOpen,
                      size: 18,
                    ),
                    backgroundColor: Colors.white,
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      size: 18,
                    ),
                    backgroundColor: Colors.white,
                    label: ''),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.message,
                      size: 18,
                    ),
                    backgroundColor: Colors.white,
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 18,
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
