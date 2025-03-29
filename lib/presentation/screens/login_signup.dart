import 'package:edutainment_app/presentation/widgets/login.dart';
import 'package:edutainment_app/presentation/widgets/signup.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors_data.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  static final routName = 'login_signup';
  @override
  State<LoginSignup> createState() => _loginSignupState();
}

class _loginSignupState extends State<LoginSignup> {

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
              isLogin?Text("If you don't have an account"):
              Text("If already have an account"),
              TextButton(onPressed: (){
                setState(() {
                  isLogin = !isLogin;
                  print(isLogin);
                });
              }, child: isLogin?Text('Sign up',style: TextStyle(color: AppColors.primary),):
              Text('Login',style: TextStyle(color: AppColors.primary),))
            ],
          )
        ],
      ),
    );
  }
}
