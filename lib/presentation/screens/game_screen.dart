import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/presentation/screens/geez_to_arabic_game_screen.dart';
import 'package:edutainment_app/presentation/screens/kebero_game_screen.dart';
import 'package:edutainment_app/presentation/screens/quiz_list_screen.dart';
import 'package:edutainment_app/presentation/screens/spelling_puzzle_screen.dart';
import 'package:flutter/material.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:edutainment_app/presentation/screens/color_match_game_screen.dart';
import 'package:edutainment_app/presentation/screens/pic_answer_screen.dart';
import 'package:edutainment_app/presentation/screens/puzzle_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../core/theme/colors_data.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  final List<dynamic> gameList = [
    {
      'name': 'Puzzle',
      'imagePath': 'assets/images/puzzle_image.png',
      'onTap': (context) {
        Navigator.pushNamed(context, PuzzleScreen.routeName);
      },
    },
    {
      'name': 'Pic Answer',
      'imagePath': 'assets/images/pic_answer_image.png',
      'onTap': (context) {
        Navigator.pushNamed(context, PicAnswerScreen.routeName);
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight - 50,
              width: double.infinity,
              child: Image.asset(
                'assets/images/games_screen_image.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 150,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:
                        context.isDarkMode
                            ? [
                              Colors.transparent,
                              Colors.black,
                              AppColors.darkBackground,
                            ]
                            : [
                              Colors.transparent,
                              Colors.white,
                              AppColors.lightBackground,
                            ],
                  ),
                ),
                child: SizedBox(
                  height: screenHeight - 300,
                  child: Column(
                    children: [
                      // NEW Container above the game list
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color:
                              context.isDarkMode
                                  ? AppColors.darkBackground
                                  : AppColors.lightBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // gameChoose(
                                //   context: context,
                                //   imagepath: 'assets/images/puzzle_image.png',
                                //   gameName: 'Kebero',
                                //   onTap: () {
                                //     Navigator.pushNamed(context, KeberoGame.routeName);
                                //   },
                                // ),
                                gameChoose(
                                  context: context,
                                  imagepath:
                                      'assets/images/color_match_image.png',
                                  gameName: 'Color Match',
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ColorMatchGameScreen.routeName,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                gameChoose(
                                  context: context,
                                  imagepath: 'assets/images/geez_image.png',
                                  gameName: 'Geez',
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      GeezToArabicGameScreen.routeName,
                                    );
                                  },
                                ),
                                gameChoose(
                                  context: context,
                                  imagepath: 'assets/images/quizzer_image.png',
                                  gameName: 'Answer me',
                                  onTap: () {
                                    QuizListScreen().launch(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ListView inside Expanded
                      Expanded(
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder:
                              (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  gameChoose(
                                    context: context,
                                    imagepath: 'assets/images/puzzle_image.png',
                                    gameName: 'Puzzle 4',
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        PuzzleScreen.routeName,
                                      );
                                    },
                                  ),
                                  gameChoose(
                                    context: context,
                                    imagepath:
                                        'assets/images/pic_answer_image.png',
                                    gameName: 'Spelling puzzle',
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        SpellingPuzzleScreen.routeName,
                                      );
                                    },
                                  ),
                                ],
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget gameChoose({
  required BuildContext context,
  required String imagepath,
  required String gameName,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 120,
      width: 120,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Image.asset(imagepath, fit: BoxFit.fitWidth, height: 70),
          Text(
            gameName,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
