import 'dart:math';

import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/domain/provider/leader_board_provider.dart';
import 'package:edutainment_app/domain/provider/quiz_provider.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:edutainment_app/models/user_model.dart';
import 'package:edutainment_app/presentation/screens/quiz_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../core/theme/colors_data.dart';

class MainScreen extends StatefulWidget {





  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  void initState() {
    super.initState();

    // Delay execution until after build context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).fatchQuiz();
      UserData user = Provider.of<UserData>(context,listen: false);
      user.getUserData();
      Provider.of<LeaderBoardProvider>(context,listen: false).getLeaderBoard(email:user.user?.email);
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double imageHeight = screenHeight * 0.4;
    double containerHeight = screenHeight * 0.8;
    final userData = Provider.of<UserData>(context);
   // userData.getUserData();
    final leaderBoard = Provider.of<LeaderBoardProvider>(context);

    QuizProvider quizData = Provider.of<QuizProvider>(context);
     // print(quizData.getQuiz);

    List<dynamic> topCategory = [];
    final random = Random();

    if (quizData.getQuiz.length >= 2) {
      int randomNumber1 = random.nextInt(quizData.getQuiz.length);
      int randomNumber2 = random.nextInt(quizData.getQuiz.length);
      topCategory = [
        quizData.getQuiz[randomNumber1],
        quizData.getQuiz[randomNumber2],
      ];
    } else {
      // Handle the case where there are fewer than 2 quizzes
      // For example, if 1 item exists, just use it:
      if (quizData.getQuiz.isNotEmpty) {
        topCategory = [quizData.getQuiz.first];
      }
    }


    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Hi👋 ${userData.user!=null?userData.user?.name:''}",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          // Wrap Stack in a Container with a defined height
          Container(
            height: screenWidth > 600 ? screenWidth * 1.3 : screenWidth * 1.7,
            // color: Colors.red,// Ensure it has a height
            child: Stack(
              children: [
                // Image with some space above
                Container(
                  // height: screenHeight,
                ),
                Positioned(
                  top:screenWidth > 600 ?65:40,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/home_screen.png',
                    // height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                // Container stacked below the image
                Positioned(
                  top: screenWidth > 600 ?screenWidth*0.75:screenWidth*0.65,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 600,
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      color: context.isDarkMode?AppColors.darkBackground:AppColors.lightBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            // height: 180,
                            width: double.infinity,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                  gradient:context.isDarkMode?LinearGradient(
                                    colors: [Colors.green, Colors.black],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ):null,
                                color: context.isDarkMode?null:AppColors.lightBackground,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Top Players & score",style: TextStyle(fontWeight: FontWeight.bold)),
                                    Container(
                                      height: 81,
                                      width: 155,
                                      child: ListView.builder(itemBuilder: (context,index)=>
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              infoText(title:leaderBoard.globalLeader[index].name, isDarkMode:context.isDarkMode,),
                                              // SizedBox(width: 20,),
                                              Text(leaderBoard.globalLeader[index].totalCorrect,style: TextStyle(),)
                                            ],
                                          ),
                                      itemCount: leaderBoard.globalLeader.length >3?3:leaderBoard.globalLeader.length,
                                      ),
                                    ),

                                    // infoText(title:leaderBoard.globalLeader[1].name, isDarkMode:context.isDarkMode),
                                    // infoText(title:leaderBoard.globalLeader[0].name, isDarkMode:context.isDarkMode),

                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text('Your Rank',style: TextStyle(fontWeight: FontWeight.bold),),
                                    infoText(title:leaderBoard.your_rank>0?'${leaderBoard.your_rank}':"_", isDarkMode:context.isDarkMode),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text('Top From Each Category',style: TextStyle(fontSize: 18,color: AppColors.primary),),
                          Container(
                            height: 140,
                            width: double.infinity,
                            // color: Colors.black,
                            child: quizData.isLoading || quizData.getQuiz.length<2?Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ): ListView.builder(
                              scrollDirection:Axis.horizontal ,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        QuizQuestionScreen(quizModel: topCategory[index],).launch(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightBackground,
                                        border: Border.all(
                                          color: AppColors.primary
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                        child: Image.network('${assetUrl}${topCategory[index].image}'),
                                                                  ),
                                    ),
                                    Text(topCategory[index].title,style: TextStyle(fontSize: 12),)
                                  ],
                                ),
                              ),itemCount: 2,),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget infoText({title,isDarkMode}){
  return Text(title,style: TextStyle(color: isDarkMode?AppColors.lightBackground:AppColors.primary,),);
}