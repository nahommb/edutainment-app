import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  static final routeName = 'quiz_screen';
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Group value to keep track of selected answer
  int selectedOption = -1;

  final List<String> options = [
    'Tigray',
    'Addis Ababa',
    'Afar',
    'Amhara', // ✅ Correct one
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Text('1'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lightBackground,
              ),
              SizedBox(height: 100),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Where is Lalibela found?',
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ...List.generate(options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Row(
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: selectedOption,
                              onChanged: (val) {
                                setState(() {
                                  selectedOption = val!;
                                });
                              },
                              activeColor: AppColors.primary,
                            ),
                            Text(
                              options[index],
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
                  TextButton(onPressed: (){}, child: Text('Next',style: TextStyle(color: AppColors.primary),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
