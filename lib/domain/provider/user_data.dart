import 'package:edutainment_app/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';

class UserData with ChangeNotifier{

  bool isLoading = true;
  bool _isLoggedIn = false;

  UserModel? _user ;

  UserModel? get user =>_user;
  bool get isLoggedIn => _isLoggedIn;

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
}