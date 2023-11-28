import 'dart:collection';
import 'dart:isolate';

import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/service/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel _userModel = UserModel();
  bool isLogin = false;
  UserModel get userModel => _userModel;
  Future signin(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    userModel.isLoading = true;
    try {
      userModel.user = await _userService.signin(
          email: email, pass: pass, onSuccess: onSuccess, onFail: onFail);

      await userModel.loadCurrentUser();

      onSuccess();
      isLogin = true;
      userModel.isLoading = false;
      notifyListeners();
    } catch (e) {
      userModel.isLoading = false;
      isLogin = false;
      onFail();
    }
    notifyListeners();
  }
  signOut(){
    isLogin = false;
    _userService.signOut(userModel);
    notifyListeners();
  }
  Future<UserModel> getUserLoggin() async{
  return await _userService.getUserLoggin();
  }
}
