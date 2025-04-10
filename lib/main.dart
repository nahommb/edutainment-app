import 'package:edutainment_app/core/theme/theme_data.dart';
import 'package:edutainment_app/presentation/screens/home_screen.dart';


import 'package:edutainment_app/presentation/screens/login_signup.dart';
import 'package:edutainment_app/presentation/screens/quiz_screen.dart';
import 'package:edutainment_app/presentation/screens/story_reading_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: LoginSignup(),
      routes: {
       HomeScreen.routeName:(context)=>HomeScreen(),
        PuzzleScreen.routeName:(context)=>PuzzleScreen(),
        QuizScreen.routeName:(context)=>QuizScreen(),
      },

    );
  }
}
