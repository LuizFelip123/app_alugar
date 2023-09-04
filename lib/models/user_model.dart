import 'package:app_alugar/models/house_share_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _name;
  String? _email;
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  List<HouseShareModel> favorites = [];
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);
  UserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    _name = documentSnapshot["name"];
    _email = documentSnapshot["email"];
  }
  UserModel();
  String? get name => _name;
  String? get email => _email;
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

    _auth.signInWithEmailAndPassword(email: email, password: pass)
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
    favorites = [];
    _user = null;
    notifyListeners();
  }

  String uid() {
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
        favorites.clear();
        for (var element in docUser['favorite']) {
          await HouseShareModel.findById(element).then((value) {
            favorites.add(value);
          });
        }
      }
    }
    notifyListeners();
  }

  deleteHouse(id, List<String> imgsReferes) async {
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("favorite", arrayContains: id)
        .get();

    for (DocumentSnapshot docUser in usersSnapshot.docs) {
      List idHouses = docUser["favorite"];
      idHouses.remove(id);
      await docUser.reference.update({"favorite": idHouses});
      if (docUser.id == uid()) {
        favorites.removeWhere((element) => element.cid == id);
        print(favorites.length);
      }
    }
    for (String img in imgsReferes) {
      Reference imageRef = FirebaseStorage.instance.refFromURL(img);

      imageRef.delete();
    }
    await FirebaseFirestore.instance.collection("houses").doc(id).delete();
    notifyListeners();
  }

  Future<bool> addFavorite(String $id) async {
    final doc =
        await FirebaseFirestore.instance.collection("users").doc(uid()).get();
    List lista = doc["favorite"];
    if (!lista.contains($id)) {
      lista.add($id);
      await FirebaseFirestore.instance.collection("users").doc(uid()).update(
        {"favorite": lista},
      );

      await HouseShareModel.findById($id).then((value) {
        favorites.add(value);
        notifyListeners();
        return true;
      });
    }
    notifyListeners();

    return false;
  }

  updateUser(String email, String name) async {
    _user!.updateEmail(email);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid())
        .update({"name": name, "email": email});

    userData["name"] = name;
    userData["email"] = email;
    _email = email;
    _name = name;
    notifyListeners();
  }

  removeFavorite(HouseShareModel houseModel) async {
    final doc =
        await FirebaseFirestore.instance.collection("users").doc(uid()).get();
    List lista = doc["favorite"];
    lista.remove(houseModel.cid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid())
        .update({"favorite": lista});
    favorites.remove(houseModel);
    notifyListeners();
  }
}
