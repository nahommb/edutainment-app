import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/models/quiz_model.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizQuestionScreen extends StatefulWidget {
  static final routeName = 'quiz_screen';
  final QuizModel quizModel;
  const QuizQuestionScreen({super.key, required this.quizModel});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  // Group value to keep track of selected answer
  int selectedOption = -1;

  final List<String> options = [
    'Tigray',
    'Addis Ababa',
    'Afar',
    'Amhara', // ✅ Correct one
  ];
  final question = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     Provider.of<QuizProvider>(
        context,
        listen: false,
      ).fatchQuestion(widget.quizModel.slug);
    });

  }
  int questionIndex = 0;
  int selectedOptionIndex = 0;
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    // print(quizProvider.getQuestion[0].options[1].isCorrect);



    return Scaffold(
      appBar: CustomAppBar(),
      body:
          quizProvider.getQuestion.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Text('${questionIndex+1}'),
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.lightBackground,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height:300,
                                width: double.infinity,
                                child: Image.network('${assetUrl}${quizProvider.getQuestion[questionIndex].image}',fit: BoxFit.fill,)
                            ),
                            Text(
                              '${quizProvider.getQuestion[questionIndex].question}',
                              style: TextStyle(
                                fontSize: 25,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            ...List.generate(quizProvider.getQuestion[questionIndex].options.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  top: 10,
                                ),
                                child: Row(
                                  children: [
                                    Radio<int>(
                                      value: index,
                                      groupValue: selectedOption,
                                      onChanged: (val) {
                                        setState(() {
                                          selectedOption = val!;
                                          selectedOptionIndex = index;
                                        });
                                      },
                                      activeColor: AppColors.primary,
                                    ),
                                    Text(
                                      '${quizProvider.getQuestion[questionIndex].options[index].option}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              print(questionIndex);
                              print(selectedOptionIndex);
                              final isCorrect = quizProvider.getQuestion[questionIndex].options[selectedOptionIndex].isCorrect;
                              isCorrect?
                              setState(() {
                                if(questionIndex<quizProvider.getQuestion.length-1){
                                  questionIndex = questionIndex+1;
                                }
                                print(questionIndex);
                              }):print('wrong choice');

                            },
                            child: Text(
                              'Next',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
