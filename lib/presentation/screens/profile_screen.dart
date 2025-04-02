import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      color: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  child: Icon(Icons.person_2_outlined,size: 80,color: AppColors.primary,),
                ),
                SizedBox(height: 15,),
                Text("Tamagn Z.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.lightBackground),)
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20,left: 10,right: 20),
            height: screenHeight*0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
              color: AppColors.lightBackground,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        TextButton(onPressed: (){}, child: Text('Your Score',style: TextStyle(fontSize: 20),)),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        TextButton(onPressed: (){}, child: Text('Parent Control',style: TextStyle(fontSize: 20))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text("Setting",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        TextButton(onPressed: (){}, child: Text('Dark Mood',style: TextStyle(fontSize: 20))),
                        Spacer(),
                        Switch(value: true, onChanged: (val){})
                      ],
                    ),
                    SizedBox(height: 8,),

                    Row(
                      children: [
                        TextButton(onPressed: (){}, child: Text('Username',style: TextStyle(fontSize: 20))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        TextButton(onPressed: (){}, child: Text('Password',style: TextStyle(fontSize: 20))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ],
                )
              ],
            ),
  
          )
        ],
      ),
    );
  }
}
