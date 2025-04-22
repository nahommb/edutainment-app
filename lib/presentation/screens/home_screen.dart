import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:edutainment_app/presentation/screens/game_screen.dart';
import 'package:edutainment_app/presentation/screens/main_screen.dart';
import 'package:edutainment_app/presentation/screens/profile_screen.dart';
import 'package:edutainment_app/presentation/screens/story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Default selected index

  // Handle navigation tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    MainScreen(),
    StoryScreen(),
    GameScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],

      // Curved Bottom Navigation Bar
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react, // Other styles: fixed, flip, textIn, etc.
        backgroundColor: context.isDarkMode?AppColors.darkBackground:AppColors.primary, // Background color
        activeColor: context.isDarkMode?AppColors.primary:AppColors.lightBackground, // Active item color
        color: Colors.white, // Unselected item color
        curveSize: 100, // Adjusts the curve size
        elevation: 10,
        items: [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.menu_book_sharp, title: "Story"),
          TabItem(icon: Icons.games_outlined, title: "Games"),
          TabItem(icon: Icons.account_circle, title: "Profile"),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
