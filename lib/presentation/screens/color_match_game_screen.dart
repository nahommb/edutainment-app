import 'dart:math';
import 'package:edutainment_app/data/game_data.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class ColorMatchGameScreen extends StatefulWidget {

  static final routeName = 'color_match_game_screen';

  @override
  State<ColorMatchGameScreen> createState() => _ColorMatchGameState();
}

class _ColorMatchGameState extends State<ColorMatchGameScreen> {

  List<dynamic> colorOptions = gameData().colorOptions;

  late Map<String, dynamic> correctColor;
  late List<Map<String, dynamic>> currentChoices;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    generateNewQuestion();
  }

  void generateNewQuestion() {
    final random = Random();
    correctColor = colorOptions[random.nextInt(colorOptions.length)];
    currentChoices = [correctColor];

    while (currentChoices.length < 3) {
      final option = colorOptions[random.nextInt(colorOptions.length)];
      if (!currentChoices.contains(option)) {
        currentChoices.add(option);
      }
    }

    currentChoices.shuffle();
    feedback = '';
    setState(() {});
  }

  int score =0;
  void checkAnswer(Map<String, dynamic> selectedColor) {
    setState(() {
      if (selectedColor == correctColor) {
        feedback = '🎉 Correct!';
        score += 1;
      } else {
        print(correctColor);
        final result = gameData().loadGameData('Color Match');
        print(result['score']);
        if (result['score'] < score || result['score'] == null) {
          gameData().saveGameData('Color Match', score, 1);
        }
        score = 0;
        feedback = '❌ Try Again! it is ${selectedColor["name"]}';
      }
    });

    Future.delayed(Duration(seconds: selectedColor == correctColor ? 1 : 4), () {
      if (!mounted) return;
      generateNewQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Text('Score:$score',style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: screenHeight*0.1,),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tap the color: ${correctColor['name']}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.primary),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: currentChoices.map((colorOption) {
                    return GestureDetector(
                      onTap: () => checkAnswer(colorOption),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: colorOption['color'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                Text(
                  feedback,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
