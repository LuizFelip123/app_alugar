
import 'package:app_alugar/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService{
  UserRepository _userRepository = UserRepository();
  User? _user; 
  FirebaseAuth _auth = FirebaseAuth.instance;
 User? signup(Map userData, VoidCallback onSuccess, VoidCallback onFail){
      
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: userData["password"])
        .then((value) async {
      _user = value.user;

  
      onSuccess();


    }).catchError((e) {
      onFail();

     
    });
       return _user;

   }
  _saveUserData(){
   
  }



}
 
