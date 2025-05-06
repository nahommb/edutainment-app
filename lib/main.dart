import 'package:edutainment_app/core/theme/theme_data.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/presentation/screens/color_match_game_screen.dart';
import 'package:edutainment_app/presentation/screens/geez_to_arabic_game_screen.dart';
import 'package:edutainment_app/presentation/screens/home_screen.dart';
import 'package:edutainment_app/presentation/screens/kebero_game_screen.dart';


import 'package:edutainment_app/presentation/screens/login_signup.dart';
import 'package:edutainment_app/presentation/screens/parent_control_screen.dart';
import 'package:edutainment_app/presentation/screens/pic_answer_screen.dart';
import 'package:edutainment_app/presentation/screens/puzzle_screen.dart';
import 'package:edutainment_app/presentation/screens/quiz_screen.dart';
import 'package:edutainment_app/presentation/screens/story_reading_screen.dart';
import 'package:edutainment_app/presentation/screens/your_score_screen.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'domain/bloc/them_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => UserData()), // Flutter Provider
         // Add other ChangeNotifierProviders here
    ],
    child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()), // Bloc
          // Add other BlocProviders here
           ],
    child: const MyApp(),
         ),
    ),
  );
}

// MultiProvider(
// providers: [
// ChangeNotifierProvider(create: (_) => ThemeProvider()), // Flutter Provider
// // Add other ChangeNotifierProviders here
// ],
// child: MultiBlocProvider(
// providers: [
// BlocProvider(create: (_) => ThemeCubit()), // Bloc
// // Add other BlocProviders here
// ],
// child: const MyApp(),
// ),
// ),


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>ThemeCubit())
    ],

        child: BlocBuilder<ThemeCubit,ThemeMode>(builder: (context,mode)=>
            MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode,
              home: LoginSignup(),
              routes: {
                HomeScreen.routeName:(context)=>HomeScreen(),
                StoryReadingScreen.routeName:(context)=>StoryReadingScreen(),
                QuizScreen.routeName:(context)=>QuizScreen(),
                PuzzleScreen.routeName:(context)=>PuzzleScreen(),
                PicAnswerScreen.routeName:(context)=>PicAnswerScreen(),
                YourScoreScreen.routeName:(context)=>YourScoreScreen(),
                ParentControlScreen.routeName:(context)=>ParentControlScreen(),
                ColorMatchGameScreen.routeName:(context)=>ColorMatchGameScreen(),
                KeberoGame.routeName:(context)=>KeberoGame(),
                GeezToArabicGameScreen.routeName:(context)=>GeezToArabicGameScreen(),
              },

            )
        )

    )    ;
  }
}
