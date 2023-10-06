
import 'dart:ui';

import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/repository/user_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository implements IUserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserModel> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future save(UserModel userModel) async {
    // TODO: implement save
    
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uid())
        .set(userModel.toMap())
        .onError((error, stackTrace) {});
  }

  @override
  Future update(UserModel userModel) {
    // TODO: implement update
    throw UnimplementedError();
  }

 


}