import 'dart:collection';
import 'dart:isolate';

import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/service/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService _userService = UserService();
  final _userModel = UserModel();
  bool isLogin = false;
  UserModel get userModal => _userModel;
  Future signin(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    _userModel.isLoading = true;
    try {
      _userModel.user = await _userService.signin(
          email: email, pass: pass, onSuccess: onSuccess, onFail: onFail);

      await _userModel.loadCurrentUser();

      onSuccess();
      isLogin = true;
      _userModel.isLoading = false;
      notifyListeners();
    } catch (e) {
      _userModel.isLoading = false;
      isLogin = false;
      onFail();
    }
    notifyListeners();
  }
  signOut(){
    isLogin = false;
    _userService.signOut(_userModel);
    notifyListeners();
  }

}
