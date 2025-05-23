import 'package:edutainment_app/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserData with ChangeNotifier{

  bool isLoading = true;
  bool _isLoggedIn = false;
  bool isSignedUp = false;

  UserModel? _user ;
  List<UserModel> _myChildList = [];

  UserModel? get user =>_user;
  List<UserModel> get myChildList => _myChildList;

  bool get isLoggedIn => _isLoggedIn;

  String loginErrorMessage ='';


  Future<void> saveUserData(String name, String email, String? image, int? type,int? id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name);
    await prefs.setString('email', email);

    if (id != null) {
      await prefs.setInt('id', id);
    }

    if (image != null) {
      await prefs.setString('image', image);
    }

    if (type != null) {
      await prefs.setInt('type', type);
    }

    print('Saved user type: $type');
  }


  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();


    final name = prefs.getString('name');
    final email = prefs.getString('email');
    final image = prefs.getString('image');
    final type = prefs.getInt('type');
    final id = prefs.getInt('id');

    print('retrieved type $type');
    print('retrieved id $id');
    print('shared prefreance test');
    if (name != null && email != null ) {
      _user = UserModel(name: name, email: email,image: image,type: type,id: id); // ✅ proper conversion
      _isLoggedIn = true;
      print('leeeeeeeee $type');
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
        loginErrorMessage = errorMessage;
        _isLoggedIn = false;
        isLoading = true;
      },
          (r) {
            _user = r;
            _isLoggedIn = true;
             isLoading = true;
              print('user type ${r.id}');
             saveUserData(r.name, r.email,r.image,r.type,r.id,);
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
              saveUserData(user.name, user.email,user.image,user.type,user.id);
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
    bool isSuccess = false;
    result.fold((l){
      print(l);
    }, (user){
      print('test image${user.image}');
      saveUserData(user.name, user.email,user.image,user.type,user.id);
      isSuccess = true;
    });

    notifyListeners();
    return isSuccess;
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('image');
    await  prefs.remove('type');

    _user = null;
    _isLoggedIn = false;
    notifyListeners(); // if using Provider or similar state management
  }

  Future<bool> addStudent({name,email,password}) async {
    final result = await AuthRepository().addStudents(name: name, email: email, password: password);
    bool isCreated = false;
    result.fold((l){
      print(l);
    }, (r){
      print(r);
      isCreated = true;
      return isCreated;
    });
    notifyListeners();
    return isCreated;
  }

  Future<void> getStudent() async {
    final result = await AuthRepository().getStudent();
    result.fold((l){
      print(l);
    }, (r){
      _myChildList = r;
      print(_myChildList[0].name);
    });
    notifyListeners();
  }

  Future<bool> removeStudent(id) async {
    final result = await AuthRepository().removeStudent(id: id);
    bool isremoved = false;
    result.fold((l){
      print(l);
    }, (r){
      print(r);
      isremoved = true;
      return isremoved;
    });
    notifyListeners();
    return isremoved;
  }
}