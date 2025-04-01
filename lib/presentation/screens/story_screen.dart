import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                  colors: [
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
                          GestureDetector(
                            onTap: (){
                              print('test');
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5,top: 5),
                              width: screenWidth*0.6,

                              height: 55,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(

                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.menu_book_rounded,color:AppColors.primary,),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: [
                                      SizedBox(height: 5,),
                                      Text("Ethiopia",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary),),
                                      Text('Ethiopian Culture',style: TextStyle(fontSize: 10,color: AppColors.primary),)
                                    ],
                                  )
                                ],
                              )
                            ),

                          ),
                          SizedBox(
                            height: 30,

                            child: ElevatedButton(onPressed: (){}, child: Text(
                              'Quiz',style: TextStyle(color: AppColors.lightBackground,fontWeight: FontWeight.normal),
                            )),
                          )
                        ],
                      ),
                      itemCount: 27,
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
