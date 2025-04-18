import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bloc/them_cubit.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

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
            padding: EdgeInsets.only(top: 20,left: 20,right: 20),
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
                    GestureDetector(
                      onTap: (){
                        print('tapped');
                      },
                      child: Row(
                        children: [
                          Text('Your Score',style: TextStyle(fontSize: 20,color: AppColors.primary),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                     GestureDetector(
                       child:Row(
                        children: [
                          Text('Parent Control',style: TextStyle(fontSize: 20,color: AppColors.primary)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                                           ),
                     )
                  ],
                ),
                SizedBox(height: 10,),
                Text("Setting",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.primary),),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    GestureDetector(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dark Mood',style: TextStyle(fontSize: 20,color: AppColors.primary)),
                          Spacer(),
                          Switch(
                            value: isDark,
                            onChanged: (val) {
                              context.read<ThemeCubit>().updateTheme(
                                val ? ThemeMode.dark : ThemeMode.light,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),

                     GestureDetector(
                       child: Row(
                        children: [
                          Text('Username',style: TextStyle(fontSize: 20,color: AppColors.primary)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                                           ),
                     ),
                    SizedBox(height: 8,),
                     GestureDetector(
                       child: Row(
                        children: [
                          Text('Password',style: TextStyle(fontSize: 20,color: AppColors.primary)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                                           ),
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
