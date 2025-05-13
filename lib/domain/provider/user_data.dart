import 'package:edutainment_app/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserData with ChangeNotifier{

  bool isLoading = true;
  bool _isLoggedIn = false;
  bool isSignedUp = false;

  UserModel? _user ;

  UserModel? get user =>_user;
  bool get isLoggedIn => _isLoggedIn;



  Future<void> saveUserData(String name, String email,String? image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('image', image!);
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();


    final name = prefs.getString('name');
    final email = prefs.getString('email');
    final image = prefs.getString('image');

    if (name != null && email != null) {
      _user = UserModel(name: name, email: email,image: image); // ✅ proper conversion
      _isLoggedIn = true;
      print(name);
    }
 //  print('leeee${_user?.email}');

  }




  Future <bool> login({email,password}) async{
    isLoading = true;
    final result = await AuthRepository().login(email: email, password: password);
    isLoading = false;
    result.fold(
          (errorMessage) {
        // handle error
        print('Login failed: $errorMessage');
        _isLoggedIn = false;
        isLoading = true;
      },
          (user) {
            _user = user;
            _isLoggedIn = true;
             isLoading = true;

             saveUserData(user.name, user.email,user.image);
      },
    );

    notifyListeners();
   return _isLoggedIn;
  }

  Future<bool> signUp({name,email,password}) async{
    isLoading = true;
    final result = await AuthRepository().signup(name: name, email: email, password: password);
    result.fold(
            (errorMessage){
              isLoading = false;
            },
            (user){
              isLoading = false;
              isSignedUp = true;
              _user = user;
              saveUserData(user.name, user.email,user.image);
            }
    );
    notifyListeners();
    return isSignedUp;
  }

  Future<bool> changePassword({oldPassword,newPassword}) async {
    final result = await AuthRepository().changePassword(oldPassword: oldPassword, newPassword: newPassword);
    bool success = false;
    result.fold(
            (l){
              print(l);
              success = false;
            },
            (r){
         print(r);
         success = true;
    });
    notifyListeners();
    return success;
  }
  Future<bool>changeProfile({email,name,image})async{
    final result = await AuthRepository().updateProfile(email: email, name: name, image: image);
    result.fold((l){}, (r){});

    notifyListeners();
    return true;
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');

    _user = null;
    _isLoggedIn = false;
    notifyListeners(); // if using Provider or similar state management
  }
}