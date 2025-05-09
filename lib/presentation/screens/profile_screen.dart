import 'dart:io';

import 'package:edutainment_app/core/dio_config.dart';
import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/helper/image_picker.dart';
import 'package:edutainment_app/helper/is_darkmode.dart';
import 'package:edutainment_app/presentation/screens/login_signup.dart';
import 'package:edutainment_app/presentation/screens/parent_control_screen.dart';
import 'package:edutainment_app/presentation/screens/your_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../domain/bloc/them_cubit.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Password', style: TextStyle(color: AppColors.primary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  controller: oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Old Password',
                    hintStyle: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(ctx).pop(); // Close the dialog
                await Future.delayed(Duration(milliseconds: 200)); // Wait to ensure pop completes

                final userData = Provider.of<UserData>(context, listen: false);
                final success = await userData.changePassword(
                  oldPassword: oldPasswordController.text,
                  newPassword: newPasswordController.text,
                );

                if (!mounted) return;

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(success ? 'Success' : 'Error'),
                    content: Text(success
                        ? 'Password Successfully Changed'
                        : 'Failed to change password'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );

                oldPasswordController.clear();
                newPasswordController.clear();
              },
              child: Text('OK', style: TextStyle(color: AppColors.primary)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }
  File? _pickedImage;

  void _pickImage() async {
    print('lee');
    final picker = MyImagePicker();
    final image = await picker.pickImageFromGallery();
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final userData = Provider.of<UserData>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      color: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  child: userData.user?.image !=null?Image.network('$assetUrl${userData.user?.image}'):Icon(Icons.person_2_outlined, size: 80, color: AppColors.primary),
                ),
                SizedBox(height: 15),
                Text(
                  userData.user?.name ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.lightBackground),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: screenHeight * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: context.isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, YourScoreScreen.routeName),
                  child: Row(
                    children: [
                      Text('Your Score', style: TextStyle(fontSize: 20, color: AppColors.primary)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
                SizedBox(height: 8),
                // GestureDetector(
                //   onTap: () => Navigator.pushNamed(context, ParentControlScreen.routeName),
                //   child: Row(
                //     children: [
                //       Text('Parent Control', style: TextStyle(fontSize: 20, color: AppColors.primary)),
                //       Spacer(),
                //       Icon(Icons.arrow_forward_ios_outlined)
                //     ],
                //   ),
                // ),
                SizedBox(height: 20),
                Text("Setting", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Dark Mode', style: TextStyle(fontSize: 20, color: AppColors.primary)),
                    Spacer(),
                    Switch(
                      value: isDark,
                      onChanged: (val) {
                        context.read<ThemeCubit>().updateTheme(val ? ThemeMode.dark : ThemeMode.light);
                      },
                    )
                  ],
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (_)=>AlertDialog(
                      title: Text('Change Profile'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height:50,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Username'
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: 'Email'
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 100,
                            child:_pickedImage != null
                                ? Image.file(_pickedImage!)
                                : Text('No image selected'),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text('Upload Profile Picture'),
                                IconButton(onPressed:  _pickImage, icon: Icon(Icons.upload)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          userData.changeProfile(name: userNameController.text,email: emailController.text,image: _pickedImage);

                        }, child: Text('Ok')),
                        TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel'))
                      ],
                    ));
                  },
                  child: Row(
                    children: [
                      Text('Change Profile', style: TextStyle(fontSize: 20, color: AppColors.primary)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _showChangePasswordDialog(context),
                  child: Row(
                    children: [
                      Text('Password', style: TextStyle(fontSize: 20, color: AppColors.primary)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                // Spacer(),
                TextButton(
                  onPressed: () {
                    showDialog(context: context, builder: (_)=>AlertDialog(
                      title: Text('Logout Request'),
                      content: Text('Are You Sure Want Logout'),
                      actions: [
                        TextButton(onPressed: (){
                          DioClient().deltetAuthToken();
                          userData.logoutUser();
                          Navigator.pushReplacementNamed(context, LoginSignup.routName);
                        }, child: Text('Ok')),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Cancel'))

                      ],
                    ));
                  },
                  child: Text('Log out', style: TextStyle(color: AppColors.primary)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
