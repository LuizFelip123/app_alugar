import 'dart:ffi';

import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/repository/user_repository.dart';
import 'package:app_alugar/service/house_share_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService {
  final _userRepository = UserRepository();
  final _auth = FirebaseAuth.instance;
  User? signup(Map userData, VoidCallback onSuccess, VoidCallback onFail) {
    User? user;
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: userData["password"])
        .then((value) async {
      user = value.user;

      onSuccess();
    }).catchError((e) {
      onFail();
    });
    return user;
  }

  saveUserData(UserModel userModel) {
    _userRepository.save(userModel);
  }

  Future<User?> signin(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    UserCredential user;
    user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return user.user;
  }
  signOut (UserModel userModel) async {
    await _auth.signOut();
    userModel.userData = {};
    userModel.favorites = [];
    userModel.user = null;
  }

  String? getUserId(){
    User? user = _auth.currentUser;
    return user?.uid;
  }
 Future<UserModel> getUserLoggin() async{
  return await _userRepository.get(_auth.currentUser!.uid);
  }
  Future<List<UserModel>> getInterested(List ids){
    return _userRepository.getInterested(ids);
  }

addFavorite(HouseShareModel houseShareModel, UserModel userModel )async {
  bool status =   await  _userRepository.setFavorite(houseShareModel.cid!, _auth.currentUser!.uid);
    if(status){
      userModel.favorites.add(houseShareModel);
    }
  }

 Future<UserModel> loadCurrentUser(UserModel userModel) async {

    if (userModel.user == null) {
      userModel.user == _auth.currentUser;
    }
    if (userModel.user != null) {
      print(userModel.userData["name"]);
      if (userModel.userData["name"] == null) {

        userModel  = await  _userRepository.get(userModel.user!.uid);
       }
      // fazer busca pelo favorites do usuários


      for(var id in userModel.userData['favorite']){

        final house = await _userRepository.getFavorite(id);
        userModel.favorites.add(house);
        }
      }
    return userModel;
  }
  Future<bool> addInterested(HouseShareModel houseShareModel)async {
     return await _userRepository.addInterested(houseShareModel, _auth.currentUser!.uid );
  }

  update(UserModel userModel,String name, String email) async {
  await   _userRepository.update(name, email, _auth.currentUser!.uid)  ;
    userModel.userData['name'] = name;
    userModel.userData['email'] = email;
  }

  deleteFavorite(HouseShareModel houseShareModel, UserModel userModel) async {
    await _userRepository.deleteFavorite( _auth.currentUser!.uid, userModel, houseShareModel);
    userModel.favorites.removeWhere((fav) => fav.cid == houseShareModel.cid);
  }
}
