import 'package:edutainment_app/presentation/widgets/login.dart';
import 'package:edutainment_app/presentation/widgets/signup.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class loginSignup extends StatefulWidget {
  const loginSignup({super.key});

  @override
  State<loginSignup> createState() => _loginSignupState();
}

class _loginSignupState extends State<loginSignup> {

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height:screenHeight*0.52,
            width: double.infinity,
            // color: Colors.lightBlue,
            child: Image.asset('assets/images/login_signup.png'),
          ),
          isLogin?login():signup(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("If you don't have an account"),
              TextButton(onPressed: (){
                setState(() {
                  isLogin = !isLogin;
                  print(isLogin);
                });
              }, child: Text('Sign up',style: TextStyle(color: AppColors.primary),))
            ],
          )
        ],
      ),
    );
  }
}
