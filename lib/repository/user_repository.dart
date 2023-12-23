

import 'dart:ffi';

import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/repository/user_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserRepository  implements IUserRepository {

  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserModel> get(String id) async {
    print("IDDD $id ");
   DocumentSnapshot snapshot = await  FirebaseFirestore.instance
        .collection("users")
        .doc(id).get();
  return UserModel.fromDocumentSnapshot(snapshot);
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
  Future update(String name, String email, String id) async {
    // TODO: implement update

    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"name": name, "email": email});

  }

  @override
  Future<List<UserModel>> getInterested(List ids ) async {
    List<UserModel> users = [];
   for(String id in ids ) {
     DocumentSnapshot snapshot = await  FirebaseFirestore.instance
         .collection("users")
         .doc(id).get();
    users.add(UserModel.fromDocumentSnapshot(snapshot));
    }
   return users;
  }
setFavorite(String id , String idUser) async {
   final doc = await FirebaseFirestore.instance.collection("users").doc(idUser).get();
   List lista = doc["favorite"];
   if (!lista.contains(id)) {
     lista.add(id);
     await FirebaseFirestore.instance.collection("users").doc(idUser).update(
       {"favorite": lista},
     );

     return true;
   }
   return false;

 }

  @override
  Future<HouseShareModel> getFavorite(String id) async {
    // TODO: implement getFavorite
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("houses")
        .doc(id)
        .get();
    return HouseShareModel.fromSnapshot(documentSnapshot);
  }

  @override
  Future<bool> addInterested(HouseShareModel houseShareModel, String id) async {
    // TODO: implement addInterested
    print("${houseShareModel.cid} -------- ID DA CASA");
    DocumentSnapshot docHouse = await FirebaseFirestore.instance.collection("houses").doc(houseShareModel.cid).get();
 print(docHouse["interested"]);
    List interested = docHouse["interested"] as List<dynamic>;
    if (!interested.contains(id)) {
      interested.add(id);
    } else {
      return false;
    }
    try {
      await FirebaseFirestore.instance
          .collection("houses")
          .doc(houseShareModel.cid)
          .update({"interested": interested});

      return true;
    } catch (e) {
      print("Erro: $e");
      return false;
    }
  }

  @override
  deleteFavorite(String id,UserModel userModel, HouseShareModel houseShareModel) async {
    final doc =
    await FirebaseFirestore.instance.collection("users").doc(id).get();
    List list = doc["favorite"];
    list.remove(houseShareModel.cid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"favorite": list});
    userModel.favorites.remove(houseShareModel);

  }




}