import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ParentControlScreen extends StatelessWidget {

  static final routeName = 'parent_control_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView.builder(itemBuilder: (context,index)=>ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text('Zewudu',style: TextStyle(color: AppColors.primary),),
        ),itemCount: 3,),
      ),
    );
  }
}
