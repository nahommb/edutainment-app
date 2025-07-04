import 'package:edutainment_app/core/dio_config.dart';
import 'package:edutainment_app/core/theme/theme_data.dart';
import 'package:edutainment_app/data/game_data.dart';
import 'package:edutainment_app/domain/provider/leader_board_provider.dart';
import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/domain/provider/spelling_provider.dart';
import 'package:edutainment_app/domain/provider/story_provider.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/presentation/screens/color_match_game_screen.dart';
import 'package:edutainment_app/presentation/screens/geez_to_arabic_game_screen.dart';
import 'package:edutainment_app/presentation/screens/home_screen.dart';
import 'package:edutainment_app/presentation/screens/init_screen.dart';
import 'package:flutter/services.dart';
import 'package:edutainment_app/presentation/screens/login_signup.dart';
import 'package:edutainment_app/presentation/screens/onboarding_screen.dart';
import 'package:edutainment_app/presentation/screens/parent_control_screen.dart';
import 'package:edutainment_app/presentation/screens/pic_answer_screen.dart';
import 'package:edutainment_app/presentation/screens/puzzle_screen.dart';
import 'package:edutainment_app/presentation/screens/quiz_list_screen.dart';
import 'package:edutainment_app/presentation/screens/quiz_question_screen.dart';
import 'package:edutainment_app/presentation/screens/quiz_screen.dart';
import 'package:edutainment_app/presentation/screens/spelling_puzzle_screen.dart';
import 'package:edutainment_app/presentation/screens/story_reading_screen.dart';
import 'package:edutainment_app/presentation/screens/your_score_screen.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'domain/bloc/them_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Open the box where your game data will be stored
  await Hive.openBox('gamesData');
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? seenOnboard = prefs.getBool('seenOnboard') ?? false;

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory(),
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.green, // Change this to any color
    statusBarIconBrightness: Brightness.light, // or Brightness.light


    systemNavigationBarColor: Colors.white, // Bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark, // Icon color on the nav bar
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => gameData()),
        ChangeNotifierProvider(create: (_) => LeaderBoardProvider()),
        ChangeNotifierProvider(create: (_) => SpellingProvider()),
        // Flutter Provider
        // Add other ChangeNotifierProviders here
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()), // Bloc
          // Add other BlocProviders here
        ],
        child: MyApp(seenOnboard: seenOnboard),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final seenOnboard;

  const MyApp({super.key, this.seenOnboard});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [BlocProvider(create: (_) => ThemeCubit())],

      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder:
            (context, mode) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode,
              home:
                  seenOnboard
                      ? InitScreen()
                      : OnboardingScreen(), //InitScreen()
              routes: {
                HomeScreen.routeName: (context) => HomeScreen(),
                LoginSignup.routName: (context) => LoginSignup(),
                // StoryReadingScreen.routeName: (context) => StoryReadingScreen(),
                QuizScreen.routeName: (context) => QuizScreen(),
                PuzzleScreen.routeName: (context) => PuzzleScreen(),
                SpellingPuzzleScreen.routeName:
                    (context) => SpellingPuzzleScreen(),
                PicAnswerScreen.routeName: (context) => PicAnswerScreen(),
                YourScoreScreen.routeName: (context) => YourScoreScreen(),
                ParentControlScreen.routeName:
                    (context) => ParentControlScreen(),
                ColorMatchGameScreen.routeName:
                    (context) => ColorMatchGameScreen(),
                GeezToArabicGameScreen.routeName:
                    (context) => GeezToArabicGameScreen(),
                QuizListScreen.routeName: (context) => QuizListScreen(),
              },
            ),
      ),
    );
  }
}
