import 'dart:io';

import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseShareModel extends Model {
  String? _cid;
  bool? _shareHouse;
  String? _descricao;
  double? _valor;
  String? _cidade;
  String? _estado;
  String? get descricao => _descricao;
  List<File> _imgsFile = [];
  List<String> _imgsLink = [];
  Map<String, dynamic> _houseData = {};
  List<dynamic> _interested = [];
  String? _generoConvivente;
  int? _quant;
  HouseShareModel();
  HouseShareModel.fromSnapshot(DocumentSnapshot snapshot) {
    cid = snapshot.id;
    shareHouse = snapshot["shareHouse"];

    cidade = snapshot['cidade'];
    descricao = snapshot['descricao'];
    estado = snapshot['estado'];
    valor = snapshot['valor'];
    interested = snapshot["interested"];
    _generoConvivente = snapshot["genero"];
    _quant = int.tryParse(snapshot["quant"]);
    for (String imgs in snapshot["imagens"]) {
      imgsLink.add(imgs);
    }
  }
  HouseShareModel.fromMap(Map<String, dynamic> map) {
    cid = map['id'];
    shareHouse = map["shareHouse"];
    cidade = map['cidade'];
    descricao = map['descricao'];
    estado = map['estado'];
    valor = map['valor'];
    interested = map["interested"];
    _generoConvivente = map["genero"];
    _quant = int.tryParse(map["quant"]);
    for (String imgs in map["imagens"]) {
      imgsLink.add(imgs);
    }
  }
  String? get genero => _generoConvivente;
  int? get quant => _quant;
   set shareHouse(bool? shareHouse) {
    _shareHouse = shareHouse;
  }

  set valor(double? valor) {
    _valor = valor;
  }

  set cid(String? cid) {
    _cid = cid;
  }

  set descricao(String? descricao) {
    _descricao = descricao;
  }

  set cidade(String? cidade) {
    _cidade = cidade;
  }

  set estado(String? estado) {
    _estado = estado;
  }

  set imgsFile(List<File> imgsFile) {
    _imgsFile = imgsFile;
  }

  set houseData(Map<String, dynamic> map) {
    _houseData = map;
  }

  set imgsLink(List<String> imgsLink) {
    _imgsLink = imgsLink;
  }

  set interested(List<dynamic> interested) {
    _interested = interested;
  }

  bool? get shareHouse => _shareHouse;
  double? get valor => _valor;
  String? get cid => _cid;
  String? get cidade => _cidade;
  String? get estado => _estado;
  List<File> get imgsFile => _imgsFile;
  Map<String, dynamic> get houseData => _houseData;
  List<String> get imgsLink => _imgsLink;
  List<dynamic> get interested => _interested;

  void saveHouse(Map<String, dynamic> houseData) async {
    await _saveImgs().then((value) async {
      final urls = value;
      try {
        houseData['imagens'] = urls;
        
        await FirebaseFirestore.instance
            .collection("houses")
            .doc()
            .set(houseData);
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

  static Future<HouseShareModel> findById(String id) async {
    final doc =
        await FirebaseFirestore.instance.collection("houses").doc(id).get();
    if (!doc["shareHouse"]) return HouseShareModel.fromSnapshot(doc);
    return HouseShareModel.fromSnapshot(doc);
  }

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
