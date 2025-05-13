import 'package:edutainment_app/domain/provider/story_provider.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:edutainment_app/presentation/screens/puzzle_screen.dart';
import 'package:edutainment_app/presentation/screens/quiz_screen.dart';
import 'package:edutainment_app/presentation/screens/story_reading_screen.dart';
import 'package:edutainment_app/repository/story_repository.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../core/theme/colors_data.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StoryProvider>(context,listen: false).getStory();
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    StoryProvider storyData = Provider.of<StoryProvider>(context);

    return Container(
      margin: EdgeInsets.all(0),
      child: Stack(
        children: [
          Container(),
          Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/story_screen_image.png',fit: BoxFit.cover,)),
          Positioned(
            bottom: 0,
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: context.isDarkMode?
                  [
                    Colors.transparent,
                    Colors.black, // Lighter shade at the top
                    AppColors.darkBackground, // Darker shade at the bottom
                  ]:
                  [
                    Colors.transparent,
                    Colors.white, // Lighter shade at the top
                    AppColors.lightBackground, // Darker shade at the bottom
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.45,),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    height: screenHeight*0.39,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                // StoryRepository().getStory();
                                StoryReadingScreen(
                                  storyModel:storyData.story[index]
                                ).launch(context);
                                // Navigator.pushNamed(context, StoryReadingScreen.routeName,);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5,top: 5),
                                //width: screenWidth*0.6,
                                padding: EdgeInsets.only(right: 10),
                                height: 45,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primary),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Row(

                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.menu_book_rounded,color:AppColors.primary,),
                                    SizedBox(width: 10,),
                                    Column(
                                      children: [
                                        SizedBox(height: 5,),
                                        Text('${storyData.story[index].title}',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary,fontSize: 10),),
                                        Text('${storyData.story[index].description}',style: TextStyle(fontSize: 10,color: AppColors.primary),)
                                      ],
                                    )
                                  ],
                                )
                              ),

                            ),
                          ),
                          SizedBox(width: 10,),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(onPressed: (){
                              Navigator.pushNamed(context, QuizScreen.routeName);
                            }, child: Text(
                              'Quiz',style: TextStyle(color: AppColors.lightBackground,fontWeight: FontWeight.normal,fontSize: 12),
                            )),
                          )
                        ],
                      ),
                      itemCount: storyData.story.length,
                    ),
                  )
                ],
              ),
              //height: 400,
            ),
          )
        ],
      ),
    );
  }
}
