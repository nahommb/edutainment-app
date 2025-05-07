import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/data/game_data.dart';
import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/game_data.dart';


class YourScoreScreen extends StatefulWidget {

  static final routeName = 'your_score_screen';

  @override
  State<YourScoreScreen> createState() => _YourScoreScreenState();
}

class _YourScoreScreenState extends State<YourScoreScreen> {

  void initState() {
    super.initState();
    init();
  }
  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<gameData>(context,listen: false).loadAllGameDataAsList();

    });

  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);

    // Provider.of<gameData>(context).loadAllGameDataAsList();

    final scoreData = Provider.of<gameData>(context);

    // print(game.loadAllGameDataAsList()[0]);

    return Scaffold(
    appBar: CustomAppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: screenHeight*0.4,
            child:ListView.builder(itemBuilder: (context, index) => ListTile(
              title: Text('${quizProvider.getQuiz[index].title}',style: TextStyle(color: AppColors.primary),),
              trailing: Text('65',style: TextStyle(color: AppColors.primary),),
            ),
            itemCount: quizProvider.getQuiz.length,),
          ),
          Expanded(child: Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: AppColors.primary,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),

            child: ListView.builder(itemBuilder: (context,index)=>ListTile(
                title: Text('${scoreData.gameList[index]['game']}',style: TextStyle(color: AppColors.lightBackground,fontSize: 17),),
              trailing: Text('${scoreData.gameList[index]['data']['score']}',style: TextStyle(color: AppColors.lightBackground,fontSize: 17)),
            ),itemCount: scoreData.gameList.length,),
          ))
        ],
      ),
    );
  }
}
