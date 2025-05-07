import 'package:edutainment_app/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserData with ChangeNotifier{

  bool isLoading = true;
  bool _isLoggedIn = false;

  UserModel? _user ;

  UserModel? get user =>_user;
  bool get isLoggedIn => _isLoggedIn;



  Future<void> saveUserData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();


    final name = prefs.getString('name');
    final email = prefs.getString('email');

    if (name != null && email != null) {
      _user = UserModel(name: name, email: email); // ✅ proper conversion
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
             saveUserData(user.name, user.email);
      },
    );

    notifyListeners();
   return _isLoggedIn;
  }

  Future<bool> signUp({name,email,password}) async{
    final result = await AuthRepository().signup(name: name, email: email, password: password);
    result.fold(
            (errorMessage){},
            (user){}
    );
    notifyListeners();
    return _isLoggedIn;
  }

  Future<void> changePassword({oldPassword,newPassword}) async {
    final result = await AuthRepository().changePassword(oldPassword: oldPassword, newPassword: newPassword);

    result.fold(
            (l){
              print(l);
            },
            (r){
         print(r);
    });
    notifyListeners();
  }
}