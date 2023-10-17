import 'dart:collection';

import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/service/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel _userModel = UserModel();

  UserModel get userMOdal => _userModel;
  Future signin(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
      _userModel.isLoading = true;
      try {
        
      _userModel.user  = await _userService.signin(email: email, pass: pass, onSuccess: onSuccess, onFail: onFail);
      _userModel.loadCurrentUser();
      onSuccess();
      _userModel.isLoading = false;
      } catch (e) {
        
      _userModel.isLoading = false;
        onFail();
        
      }
      notifyListeners();  
      }
}
