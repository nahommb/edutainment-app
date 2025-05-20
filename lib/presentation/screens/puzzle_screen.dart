import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import '../../domain/provider/quiz_provider.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});
  static final routeName = 'puzzle_screen';

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  int questionIndex = 0;
  List<TextEditingController> puzzleControllers = [];
  Map<int, String> userAnswerMap = {};
  int score = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).fetchWordPuzzle().then((_) {
        if (mounted) {
          final provider = Provider.of<QuizProvider>(context, listen: false);
          if (provider.wordPuzzleList.isNotEmpty) {
            initializeControllers(provider.wordPuzzleList[questionIndex].answer.length);
          }
        }
      });
    });
  }

  void initializeControllers(int length) {
    for (var controller in puzzleControllers) {
      controller.dispose();
    }
    puzzleControllers = List.generate(length, (_) => TextEditingController());
    userAnswerMap.clear();
  }

  void checkAnswer(List<String> correctAnswer) {
    bool isCorrect = true;

    for (int i = 0; i < correctAnswer.length; i++) {
      final userChar = (userAnswerMap[i] ?? '').trim().toLowerCase();
      final actualChar = correctAnswer[i].toLowerCase();

      if (userChar != actualChar) {
        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {
      setState(() {
        score++;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in puzzleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordPuzzle = Provider.of<QuizProvider>(context);

    if (wordPuzzle.wordPuzzleList.isEmpty || questionIndex >= wordPuzzle.wordPuzzleList.length) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = wordPuzzle.wordPuzzleList[questionIndex];

    if (puzzleControllers.length != currentQuestion.answer.length) {
      initializeControllers(currentQuestion.answer.length);
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Pre-fill readonly letters in the answer range:
    for (int i = currentQuestion.startIndex; i <= currentQuestion.endIndex; i++) {
      if (puzzleControllers[i].text != currentQuestion.answer[i]) {
        puzzleControllers[i].text = currentQuestion.answer[i];
        userAnswerMap[i] = currentQuestion.answer[i];
      }
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Score: $score',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              Container(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: currentQuestion.answer.length,
                  itemBuilder: (context, index) {
                    final isPreFilled =
                        index >= currentQuestion.startIndex && index <= currentQuestion.endIndex;

                    return Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: TextField(
                            controller: puzzleControllers[index],
                            textAlign: TextAlign.center,
                            enabled: !isPreFilled,
                            onChanged: (val) {
                              setState(() {
                                userAnswerMap[index] = val;
                              });
                            },
                            decoration: const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              Text(
                currentQuestion.question,
                style: TextStyle(fontSize: 14, color: AppColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // instead of Spacer()
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      onPressed: () {
                        checkAnswer(currentQuestion.answer.split(''));

                        for (var controller in puzzleControllers) {
                          controller.clear();
                        }

                        if (questionIndex < wordPuzzle.wordPuzzleList.length - 1) {
                          setState(() {
                            questionIndex++;
                            initializeControllers(wordPuzzle.wordPuzzleList[questionIndex].answer.length);
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Quiz Finished"),
                              content: Text("Your final score is $score"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('Next'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
