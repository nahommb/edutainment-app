import 'package:flutter/material.dart';

import '../../core/dio_config.dart';
import 'home_screen.dart';
import 'login_signup.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DioClient().getAuthToken(), // make sure this returns Future<String>
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data != '') {
          return HomeScreen();
        } else {
          return LoginSignup();
        }
      },
    );
  }
}
