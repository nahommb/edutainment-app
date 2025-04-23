import 'dart:math';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ColorMatchGameScreen extends StatefulWidget {

  static final routeName = 'color_match_game_screen';

  @override
  State<ColorMatchGameScreen> createState() => _ColorMatchGameState();
}

class _ColorMatchGameState extends State<ColorMatchGameScreen> {
  final List<Map<String, dynamic>> colorOptions = [
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Orange', 'color': Colors.orange},
  ];

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
        score+=1;
      } else {
        feedback = '❌ Try Again!';
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      generateNewQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Text('Score:$score',style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 200,),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tap the color: ${correctColor['name']}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
