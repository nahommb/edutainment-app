import 'package:edutainment_app/repository/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class signup extends StatefulWidget {



  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  int selectedVal = -1;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Signup',style: TextStyle(fontSize: 20,color: AppColors.primary),),
          ),
          SizedBox(height: 25,),
          Container(
            height: screenHeight*0.50,
            width: 350,
            child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13),
                          border: OutlineInputBorder()

                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Email or Phone Number',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13),
                          border: OutlineInputBorder()

                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13),
                          border: OutlineInputBorder()

                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13),
                          border: OutlineInputBorder()

                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Child'),
                      Radio<int>(value: 1, groupValue: selectedVal, onChanged: (val){
                        setState(() {
                          selectedVal= val!;
                        });
                      },activeColor: AppColors.primary,),
                      SizedBox(width: 80,),
                      Text('Parent'),
                      Radio<int>(value: 2, groupValue:selectedVal, onChanged: (val){
                        setState(() {
                          selectedVal= val!;
                          print("role:parent");
                        });
                      },activeColor: AppColors.primary,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(250, 40), // Width: 200, Height: 50
                      ),
                      onPressed: (){
                        // AuthRepository().login(email: 'kajkjk@gmail.com', password: '989898') ;
                        // // AuthRepository().signup(name: 'nahom', email: 'leeopia11@gmail.com', password: '123456');
                        // print('sign up');
                      },
                      child: Text('Continue',style: TextStyle(color: AppColors.lightBackground),)
                  ),
                  Spacer(),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
