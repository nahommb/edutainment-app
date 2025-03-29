import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Dynamic positions
    double imageTop = screenWidth * 0.08;
    double containerTop = screenWidth * 0.75;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Hi lee',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            height: screenHeight * 1, // Ensure enough height for scrolling
            child: Stack(
              children: [
                // Background Container
                Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Positioned Image
                Positioned(
                  top: imageTop,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/home_screen.png',
                    fit: BoxFit.cover,
                    width: screenWidth * 0.9,
                  ),
                ),
                // Positioned Bottom Container
                Positioned(
                  top: containerTop,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenWidth > 600 ? 20 : 10),
                        topRight: Radius.circular(screenWidth > 600 ? 20 : 10),
                      ),
                      border: Border(
                        top: BorderSide(color: AppColors.primary),  // Keep top border
                        left: BorderSide(color: AppColors.primary), // Keep left border
                        right: BorderSide(color: AppColors.primary), // Keep right border
                        bottom: BorderSide.none, // Remove bottom border
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
