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
          title: Text('Change Password', style: TextStyle(color: AppColors.primary,fontSize: 14)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 35,
                width: 200,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Old Password',
                    hintStyle: TextStyle(color: AppColors.primary,fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 35,
                width: 200,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: TextStyle(color: AppColors.primary,fontSize: 12),
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
              child: Text('Cancel', style: TextStyle(color: AppColors.gray)),
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: screenHeight,
        color: AppColors.primary,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Container(
                      width: 160, // 2 * radius
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.lightBackground, // Change this to your desired color
                          width: 4, // Thickness of the border
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey[200], // optional background
                        backgroundImage: userData.user?.image != null
                            ? NetworkImage('$assetUrl${userData.user?.image}')
                            : null,
                        child: userData.user?.image == null
                            ? Icon(Icons.person_2_outlined, size: 80, color: AppColors.primary)
                            : null,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      userData.user?.name ?? '',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.lightBackground),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: screenHeight * 0.54,
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
                          Text('Your Score', style: TextStyle(fontSize: 15, color: AppColors.primary)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 15,)
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
                    Text("Setting", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dark Mode', style: TextStyle(fontSize: 15, color: AppColors.primary)),
                        Spacer(),
                        SizedBox(
                          width: 30,
                          child: Transform.scale(
                            scale: 0.5,
                            child: Switch(
                              value: isDark,
                              onChanged: (val) {
                                context.read<ThemeCubit>().updateTheme(val ? ThemeMode.dark : ThemeMode.light);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (_) => StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text('Change Profile',style: TextStyle(fontSize: 16,color: AppColors.primary),),
                                content: Form(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          child: TextFormField(
                                            controller: userNameController,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 13),
                                            decoration: InputDecoration(
                                              hintText: 'Username',
                                              hintStyle: TextStyle(fontSize: 12,color: AppColors.primary),
                                              contentPadding: EdgeInsets.symmetric(vertical: 8), // Reduce height
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          height: 35,
                                          child: TextFormField(
                                            controller: emailController,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 13),
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                              hintStyle: TextStyle(fontSize: 12,color: AppColors.primary),
                                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 80,
                                          child: _pickedImage != null
                                              ? Image.file(_pickedImage!)
                                              : Text('No image selected',style: TextStyle(color: AppColors.primary),),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            children: [
                                              Text('Upload Profile Picture',style: TextStyle(color: AppColors.primary)),
                                              IconButton(
                                                onPressed: () async {
                                                  final picker = MyImagePicker();
                                                  final image = await picker.pickImageFromGallery();
                                                  if (image != null) {
                                                    setState(() {
                                                      _pickedImage = image;
                                                    });
                                                  }
                                                },
                                                icon: Icon(Icons.upload,color: AppColors.primary,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      userData.changeProfile(
                                        name: userNameController.text,
                                        email: emailController.text,
                                        image: _pickedImage,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text('Change Profile', style: TextStyle(fontSize: 15, color: AppColors.primary)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 15,)
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showChangePasswordDialog(context),
                      child: Row(
                        children: [
                          Text('Password', style: TextStyle(fontSize: 15, color: AppColors.primary)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 15,)
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
        ),
      ),
    );
  }
}
