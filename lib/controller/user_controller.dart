import 'dart:collection';
import 'dart:isolate';

import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/service/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel userModel = UserModel();
  bool isLogin = false;
  List<UserModel> interested = [];
  List<HouseShareModel> favorites = [];
  Future signin(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    userModel.isLoading = true;

      userModel.user = await _userService.signin(
          email: email, pass: pass, onSuccess: onSuccess, onFail: onFail);
  try{
      userModel = await _userService.loadCurrentUser(userModel);
    print(userModel.name);
      onSuccess();
      isLogin = true;
      userModel.isLoading = false;
      notifyListeners();
  }catch( e) {
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

  userInterested(List<dynamic> ids)async {
    interested = await _userService.getInterested(ids);
    notifyListeners();
  }
  addFavorite(HouseShareModel houseShareModel) async {
   await _userService.addFavorite(houseShareModel, userModel);

    notifyListeners();
  }
 Future<bool> addInterested(HouseShareModel houseShareModel) async {
   return await _userService.addInterested(houseShareModel);
  }
  update( String nome, String email)async  {
    await _userService.update(userModel,nome,email);

  }
  deleteFavorite(HouseShareModel houseShareModel) async {
     await _userService.deleteFavorite(houseShareModel, userModel);

     notifyListeners();
  }
}
