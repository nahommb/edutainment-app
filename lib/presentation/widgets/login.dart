import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/models/user_model.dart';
import 'package:edutainment_app/presentation/screens/home_screen.dart';
import 'package:edutainment_app/presentation/screens/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/auth_repository.dart';

class login extends StatelessWidget {
 

  late String email = '';
  late String password = '';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    double screenHeight = MediaQuery.of(context).size.height;

    final userData = Provider.of<UserData>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Login',style: TextStyle(fontSize: 20,color: AppColors.primary),),
          ),
          SizedBox(height: 25,),
          Container(
            height: screenHeight*0.3,
            width: 350,
            child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: TextFormField(
                      onChanged: (val){
                        email = val;
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Email or Phone Number',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13),
                          border: OutlineInputBorder()

                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: TextFormField(
                      onChanged: (val){
                        password = val;
                      },
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13,),
                          border: OutlineInputBorder()

                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 40), // Width: 200, Height: 50
                    ),
                    onPressed: () async{
                      if(password=='' || email==''){
                        showDialog(context: context, builder:(_)=>AlertDialog(
                          title:Text('Fill Fields') ,
                          content: Text('Please fill all required fields'),
                          actions: [
                            TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                          ],
                        ));
                      }
                      else{
                        userData.isLoading?showDialog(context: context, builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),):null;
                        bool success = await userData.login(email: email, password: password) ;
                        print(success);
                        if(success){
                          Navigator.pushNamed(context,HomeScreen.routeName);
                        };
                      }


                    // print('lee${lee}');
                    }, child: Text('Login',style: TextStyle(color: AppColors.lightBackground),)),
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
