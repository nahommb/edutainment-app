import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:flutter/material.dart';
import '../../core/theme/colors_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double imageHeight = screenHeight * 0.4;
    double containerHeight = screenHeight * 0.8;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Hi lee',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          // Wrap Stack in a Container with a defined height
          Container(
            height: screenWidth > 600 ? screenWidth * 1.3 : screenWidth * 1.7,
            // color: Colors.red,// Ensure it has a height
            child: Stack(
              children: [
                // Image with some space above
                Container(
                  // height: screenHeight,
                ),
                Positioned(
                  top:screenWidth > 600 ?65:40,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/home_screen.png',
                    // height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                // Container stacked below the image
                Positioned(
                  top: screenWidth > 600 ?screenWidth*0.85:screenWidth*0.75,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 600,
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      color: context.isDarkMode?AppColors.darkBackground:AppColors.lightBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.darkGray,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Text('leee'),
                          ),
                          Text('Top From Each Categor',style: TextStyle(fontSize: 20,color: AppColors.primary),),
                          Container(
                            height: 120,
                            width: double.infinity,
                            // color: Colors.black,
                            child: ListView.builder(
                              scrollDirection:Axis.horizontal ,
                              itemBuilder: (context, index) => Container(
                                width: 120,
                                margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.lightBackground,
                                border: Border.all(
                                  color: AppColors.primary
                                ),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              // child: Text('lee'),
                            ),itemCount: 15,),
                          ),

                        ],
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
