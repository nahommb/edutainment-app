import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/models/user_model.dart';
import 'package:edutainment_app/presentation/screens/home_screen.dart';
import 'package:edutainment_app/presentation/screens/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/auth_repository.dart';

class login extends StatefulWidget {


  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

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
                    height: 35,
                    width: 250,
                    child: TextFormField(
                      controller: emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13),
                          border: OutlineInputBorder()

                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 35,
                    width: 250,
                    child: TextFormField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: AppColors.primary,fontSize: 13,),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),

                    ),
                  ),
                  SizedBox(height: 15,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 40), // Width: 200, Height: 50
                    ),
                    onPressed: () async{
                      if(passwordController.text=='' || emailController.text==''){
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
                        bool success = await userData.login(email: emailController.text, password: passwordController.text) ;
                        Navigator.pop(context);
                        print(success);
                        if(success){
                          Navigator.pushNamed(context,HomeScreen.routeName);
                        } else{
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: Text('Failed',style: TextStyle(fontSize: 14,color: Colors.red),),
                            content: Text(userData.loginErrorMessage),
                            actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))],
                          ),);
                        }
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
