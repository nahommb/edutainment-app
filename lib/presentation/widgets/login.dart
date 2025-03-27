import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Form(
        child: Column(
          children: [
            Text('Login',style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
