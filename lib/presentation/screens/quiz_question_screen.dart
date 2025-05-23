import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/leader_board_provider.dart';
import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/models/quiz_model.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizQuestionScreen extends StatefulWidget {
  final QuizModel quizModel;
  const QuizQuestionScreen({super.key, required this.quizModel});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int questionIndex = 0;
  int score = 0;
  List<int> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<QuizProvider>(context, listen: false)
          .fatchQuestion(widget.quizModel.slug);

      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      selectedAnswers = List.filled(quizProvider.getQuestion.length, -1);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final leaderBoard = Provider.of<LeaderBoardProvider>(context);

    if (quizProvider.getQuestion.isEmpty || selectedAnswers.length != quizProvider.getQuestion.length) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text('${questionIndex + 1}', style: const TextStyle(fontSize: 12)),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.lightBackground,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (quizProvider.getQuestion[questionIndex].image != null)
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          '$assetUrl${quizProvider.getQuestion[questionIndex].image}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Text(
                        quizProvider.getQuestion[questionIndex].question,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(
                      quizProvider.getQuestion[questionIndex].options.length,
                          (index) => Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: selectedAnswers[questionIndex],
                              onChanged: (val) {
                                setState(() {
                                  selectedAnswers[questionIndex] = val!;
                                });
                              },
                              activeColor: AppColors.primary,
                            ),
                            Flexible(
                              child: Text(
                                quizProvider.getQuestion[questionIndex].options[index].option,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if (questionIndex > 0) {
                      setState(() {
                        questionIndex -= 1;
                        final selectedIndex = selectedAnswers[questionIndex];
                        if (selectedIndex != -1) {
                          final isCorrect = quizProvider.getQuestion[questionIndex]
                              .options[selectedIndex].isCorrect;
                          if (isCorrect) score--;
                        }
                      });
                    }
                  },
                  child: Text('Back', style: TextStyle(color: AppColors.primary)),
                ),
                TextButton(
                  onPressed: () {
                    final selectedIndex = selectedAnswers[questionIndex];
                    if (selectedIndex != -1) {
                      final isCorrect = quizProvider.getQuestion[questionIndex]
                          .options[selectedIndex].isCorrect;
                      if (isCorrect) score++;
                    }

                    if (questionIndex < quizProvider.getQuestion.length - 1) {
                      setState(() {
                        questionIndex++;
                      });
                    } else {
                      leaderBoard.setLeaderBoared(
                        correctAnswer: score,
                        wrongAnswer: quizProvider.getQuestion.length - score,
                        quizId: widget.quizModel.id,
                      );
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                          title: Text('Completed', style: TextStyle(color: AppColors.primary, fontSize: 12)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Completed All The Questions',
                                  style: TextStyle(color: AppColors.primary, fontSize: 12)),
                              const SizedBox(height: 20),
                              Text('Your Score: $score',
                                  style: TextStyle(color: AppColors.primary, fontSize: 12)),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                leaderBoard.getLeaderBoard();
                                setState(() {
                                  questionIndex = 0;
                                  score = 0;
                                  selectedAnswers = List.filled(quizProvider.getQuestion.length, -1);
                                });
                              },
                              child: Text('Ok', style: TextStyle(color: AppColors.primary)),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Next', style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
