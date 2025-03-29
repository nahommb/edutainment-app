import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Login',style: TextStyle(fontSize: 20),),
          SizedBox(height: 25,),
          Container(
            height: screenHeight*0.3,
            width: 350,
            child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Email or Phone number',
                      hintStyle: TextStyle(color: AppColors.primary,),
                      border: OutlineInputBorder()

                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: AppColors.primary,),
                        border: OutlineInputBorder()

                    ),
                  ),
                  SizedBox(height: 15,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50), // Width: 200, Height: 50
                    ),
                    onPressed: (){}, child: Text('Login',style: TextStyle(color: AppColors.lightBackground),)),
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
