import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/presentation/screens/quiz_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({super.key});

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<QuizProvider>(context, listen: false).getQuiz.isEmpty) {
        Provider.of<QuizProvider>(context, listen: false).fatchQuiz();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body:
          quizProvider.getQuiz.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                itemCount: quizProvider.getQuiz.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 2.5,
                      vertical: 2.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            assetUrl + quizProvider.getQuiz[index].image,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          quizProvider.getQuiz[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ).onTap(() {
                    QuizQuestionScreen(
                      quizModel: quizProvider.getQuiz[index],
                    ).launch(context);
                  });
                },
              ),
    );
  }
}
