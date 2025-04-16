import 'package:edutainment_app/presentation/screens/puzzle_screen.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image.asset('assets/images/games_screen_image.png',fit: BoxFit.cover,),
          Stack(
            children: [
              Container(
                   height: screenHeight,
                  width: double.infinity,
                  child: Image.asset('assets/images/games_screen_image.png',fit: BoxFit.cover,)),
              Positioned(
                top: 300,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // height: 800,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white,
                        Colors.white, // Lighter shade at the top
                        AppColors.lightBackground, // Darker shade at the bottom
                      ],
                    ),
                  ),
                  child: ListView.builder(itemBuilder: (context, index) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        gameChoose(context:context, imagepath:'assets/images/puzzle_image.png',gameName: 'Puzzle', onTap: (){
                            Navigator.pushNamed(context, PuzzleScreen.routeName);
                        }),
                        gameChoose(context:context, imagepath:'assets/images/pic_answer_image.png',gameName: 'Pic Answer', onTap: (){
                          Navigator.pushNamed(context, PuzzleScreen.routeName);
                        }),
                      ],
                    ),
                  itemCount: 10,),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget gameChoose({context,imagepath,gameName,onTap}){

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 120,
      width: 120,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.red,
      ),
      child: Column(
        children: [
          Image.asset(imagepath,fit: BoxFit.fitWidth,),
          Text(gameName,style: TextStyle(fontSize: 15,color: AppColors.primary),),
        ],
      ),
    ),
  );
}
