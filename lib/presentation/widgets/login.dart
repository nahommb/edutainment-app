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
                      hintText: 'Email',
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
                Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("If you don't have an account"),
                      TextButton(onPressed: (){}, child: Text('Sign up'))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
