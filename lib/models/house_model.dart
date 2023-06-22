import 'dart:io';

import 'package:app_alugar/models/house_share_model.dart';
import 'package:app_alugar/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseModel extends Model {
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
  HouseModel();
  Map<String, dynamic> toMap() {
    return {
      "descricao": _descricao,
      "valor": _valor,
      "cidade": _cidade,
      "estado": _estado,
      "imgs": imgsLink,
      "shareHouse": _shareHouse
    };
  }

  HouseModel.fromSnapshot(DocumentSnapshot snapshot) {
    _cid = snapshot.id;
    _cidade = snapshot['cidade'];
    _descricao = snapshot['descricao'];
    _estado = snapshot['estado'];
    _valor = double.parse(snapshot['valor']);
    _interested = snapshot["interested"];
    _shareHouse = snapshot["shareHouse"];
    for (String imgs in snapshot["imagens"]) {
      _imgsLink.add(imgs);
    }
  }
  HouseModel.fromMap(Map<String, dynamic> map) {
    _cid = map["id"];
    _shareHouse = map["shareHouse"];
    _cidade = map['cidade'];
    _descricao = map['descricao'];
    _estado = map['estado'];
    _valor = double.parse(map['valor']);
    _interested = map["interested"];
    for (String imgs in map["imagens"]) {
      _imgsLink.add(imgs);
    }
  }
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
  static HouseModel of(BuildContext context) =>
      ScopedModel.of<HouseModel>(context);

  void saveHouse(Map<String, dynamic> houseData) async {
    await _saveImgs().then((value) async {
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

  static Future<HouseModel> findById(String id) async {
    final doc =
        await FirebaseFirestore.instance.collection("houses").doc(id).get();
    if (!doc["shareHouse"]) return HouseModel.fromSnapshot(doc);
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
