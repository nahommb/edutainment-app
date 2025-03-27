import 'package:edutainment_app/presentation/widgets/login.dart';
import 'package:flutter/material.dart';

class loginSignup extends StatelessWidget {
  const loginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:screenHeight*0.55,
            width: double.infinity,
            color: Colors.lightBlue,
            child: Image.asset('assets/images/login_signup.png'),
          ),
          login(),
        ],
      ),
    );
  }
}
