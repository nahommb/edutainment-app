import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/presentation/screens/quiz_question_screen.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({super.key});

  static String routeName = 'quiz_list_screen';

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
      appBar: CustomAppBar(),
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
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            assetUrl + quizProvider.getQuiz[index].image,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          quizProvider.getQuiz[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
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
