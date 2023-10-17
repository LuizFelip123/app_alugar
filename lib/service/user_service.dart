import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/repository/user_repository.dart';
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
}
