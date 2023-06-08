import 'package:app_alugar/models/house_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  void signup(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((value) async {
      _user = value.user;

      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();

      isLoading = false;
      notifyListeners();
    });
  }

  void signin(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      _user = value.user;

      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print("Erro ao entra: $e");
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return _user != null;
  }

  void signOut() async {
    await _auth.signOut();
    userData = {};
    _user = null;
    notifyListeners();
  }
  String uid(){
    return _user!.uid;
  }
  
  Future _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_user!.uid)
        .set(userData)
        .onError((error, stackTrace) {});
  }

  Future _loadCurrentUser() async {
    if (_user == null) {
      _user == _auth.currentUser;
    }
    if (_user != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection("users")
            .doc(_user!.uid)
            .get();
        userData["name"] = docUser["name"];
        userData["hide"] = docUser["hide"];
        userData["email"] = docUser["email"];
      }
    }
    notifyListeners();
  }
}
