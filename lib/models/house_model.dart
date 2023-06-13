import 'dart:io';

import 'package:app_alugar/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseModel extends Model {
  String? _cid;

  String? _descricao;
  double? _valor;
  String? _cidade;
  String? _estado;
  String? get descricao => _descricao;
  List<File> _imgsFile = [];
  List<String> _imgsLink = [];
  Map<String, dynamic> _houseData = {};
  List<dynamic> _interested = [];
  HouseModel() {}
  HouseModel.fromSnapshot(DocumentSnapshot snapshot) {
    _cid = snapshot.id;
    _cidade = snapshot['cidade'];
    _descricao = snapshot['descricao'];
    _estado = snapshot['estado'];
    _valor = double.parse(snapshot['valor']);
    _interested = snapshot["interested"];
    for (String imgs in snapshot["imagens"]) {
      _imgsLink.add(imgs);
    }
  }
  HouseModel.fromMap(Map<String, dynamic> map) {
    _cid = map["id"];
    _cidade = map['cidade'];
    _descricao = map['descricao'];
    _estado = map['estado'];
    _valor = double.parse(map['valor']);
    _interested = map["interested"];
    for (String imgs in map["imagens"]) {
      _imgsLink.add(imgs);
    }
  }
  double? get valor => _valor;
  String? get cid => _cid;
  String? get cidade => _cidade;
  String? get estado => _estado;
  List<File> get imgsFile => _imgsFile;
  Map<String, dynamic> get houseData => _houseData;
  List<String> get imgsLink => _imgsLink;
  List<dynamic> get interested => _interested;
  static HouseModel of(BuildContext context) =>
      ScopedModel.of<HouseModel>(context);

  void saveHouse(Map<String, dynamic> houseData) {
    _saveImgs().then((value) async {
      final urls = value;
      try {
        houseData['imagens'] = urls;
        print("Chegou aqui");
        await FirebaseFirestore.instance
            .collection("houses")
            .doc()
            .set(houseData);
        print("Chegou aqui");
      } catch (e) {
        print("Erro = $e");
      }
    });
  }

  List<File> formatImagens(List<PickedFile>? images) {
    if (images!.isNotEmpty) {
      for (PickedFile image in images) {
        _imgsFile.add(File(image.path));
      }
    }

    return _imgsFile;
  }

  Future<List> _saveImgs() async {
    List imgUrls = [];
    for (var img in _imgsFile) {
      Reference reference =
          FirebaseStorage.instance.ref().child(DateTime.now().toString());
      UploadTask uploadTask = reference.putFile(img);

      await uploadTask.whenComplete(() {});

      try {
        final imgUrl = await reference.getDownloadURL();
        print(imgUrl);
        imgUrls.add(imgUrl);
      } catch (onError) {
        print("Error : $onError");
      }
    }
    return imgUrls;
  }

  deleteHouse(id, List<String> imgsReferes) async {
    for (String img in imgsReferes) {
      Reference imageRef = FirebaseStorage.instance.refFromURL(img);
      imageRef.delete();
    }
    await FirebaseFirestore.instance.collection("houses").doc(id).delete();
    notifyListeners();
  }

  interestedHouse() {}
  addInterested(idUser) async {
    DocumentSnapshot docHouse =
        await FirebaseFirestore.instance.collection("houses").doc(cid).get();
    final data = docHouse.data() as Map<String, dynamic>;
    List interested = data["interested"];
    if (!interested.contains(idUser)) {
      interested.add(idUser);
    } else {
      return false;
    }
    try {
      await FirebaseFirestore.instance
          .collection("houses")
          .doc(cid)
          .update({"interested": interested});
      notifyListeners();
      return true;
    } catch (e) {
      print("Erro: $e");
      return false;
    }
  }
}
