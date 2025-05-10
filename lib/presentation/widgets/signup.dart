import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/colors_data.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _SignupState();
}

class _SignupState extends State<signup> {
  int selectedVal = -1;
  String role = 'child';

  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    UserData userData = Provider.of<UserData>(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Signup', style: TextStyle(fontSize: 20, color: AppColors.primary)),
          ),
          const SizedBox(height: 25),
          Container(
            height: screenHeight * 0.50,
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildTextField(nameController, 'Full Name'),
                  const SizedBox(height: 20),
                  buildTextField(emailController, 'Email or Phone Number', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  buildTextField(passwordController, 'Password', obscureText: true),
                  const SizedBox(height: 20),
                  buildTextField(confirmPasswordController, 'Confirm Password', obscureText: true),
                  const SizedBox(height: 15),
                  buildRoleSelector(),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size(250, 40)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (selectedVal == -1) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Select Role'),
                              content: const Text('Please select either Child or Parent.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                              ],
                            ),
                          );
                          return;
                        }
                        if (passwordController.text != confirmPasswordController.text) {

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Check Password'),
                              content: const Text('Password and Confirm password do not match.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                              ],
                            ),
                          );
                          return;
                        }

                         userData.isLoading?showDialog(context: context,
                             barrierDismissible: false,
                             builder: (_)=>Center(
                          child: CircularProgressIndicator(),
                        )):null;
                         final success = await userData.signUp(name: nameController.text,email: emailController.text,password: passwordController.text);

                        Navigator.pop(context);

                        nameController.clear();
                        passwordController.clear();
                        emailController.clear();
                        confirmPasswordController.clear();
                        selectedVal = -1;

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(success ? 'Succeeded' : 'Error'),
                            content: Text(success
                                ? 'Successfully signed up. Go to login.'
                                : 'Some error occurred. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Dismiss success/error dialog
                                },
                                child: Text('Ok'),
                              )
                            ],
                          ),
                        );
                        // await AuthRepository().signup(
                        //   name: nameController.text,
                        //   email: emailController.text,
                        //   password: passwordController.text,
                        // );
                      }
                    },
                    child: const Text('Continue', style: TextStyle(color: AppColors.lightBackground)),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return SizedBox(
      height: 35,
      width: 250,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$hint is required';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.primary, fontSize: 13),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildRoleSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Child'),
        Radio<int>(
          value: 1,
          groupValue: selectedVal,
          onChanged: (val) {
            setState(() {
              selectedVal = val!;
              role = 'child';
            });
          },
          activeColor: AppColors.primary,
        ),
        const SizedBox(width: 80),
        const Text('Parent'),
        Radio<int>(
          value: 2,
          groupValue: selectedVal,
          onChanged: (val) {
            setState(() {
              selectedVal = val!;
              role = 'parent';
            });
          },
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}
