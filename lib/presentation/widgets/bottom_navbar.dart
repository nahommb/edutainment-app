import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';
import '../screens/game_screen.dart';
import '../screens/main_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/story_screen.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavbar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.react,
      backgroundColor: AppColors.primary,
      activeColor: Colors.white,
      color: Colors.white,
      curveSize: 100,
      elevation: 10,
      items: const [
        TabItem(icon: Icons.home, title: "Home"),
        TabItem(icon: Icons.menu_book_sharp, title: "Story"),
        TabItem(icon: Icons.games_outlined, title: "Games"),
        TabItem(icon: Icons.account_circle, title: "Profile"),
      ],
      initialActiveIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
