import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class YourScoreScreen extends StatelessWidget {

  static final routeName = 'your_score_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: CustomAppBar(),
    );
  }
}
