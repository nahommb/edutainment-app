import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class YourScoreScreen extends StatelessWidget {

  static final routeName = 'your_score_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: CustomAppBar(),
      body: Container(
        child:ListView.builder(itemBuilder: (context, index) => ListTile(
          title: Text('Puzzle 1',style: TextStyle(color: AppColors.primary),),
          trailing: Text('65',style: TextStyle(color: AppColors.primary),),
        ),
        itemCount: 20,),
      ),
    );
  }
}
