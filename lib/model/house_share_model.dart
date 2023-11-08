import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseShareModel extends Model {
  String? cid;
  bool? shareHouse;
  String? descricao;
  double? valor;
  String? cidade;
  String? estado;
  List<File> imgsFile = [];
  List<String> imgsLink = [];
  Map<String, dynamic> houseData = {};
  List<dynamic> interested = [];
  String? generoConvivente;
  int? quant;
  HouseShareModel();
  HouseShareModel.fromSnapshot(DocumentSnapshot snapshot) {
    cid = snapshot.id;
    shareHouse = snapshot["shareHouse"];
    cidade = snapshot['cidade'];
    descricao = snapshot['descricao'];
    estado = snapshot['estado'];
    valor = snapshot['valor'];
    interested = snapshot["interested"];
    generoConvivente = snapshot["genero"];
    quant = int.tryParse(snapshot["quant"]);
      print(snapshot["quant"]);
      print(snapshot["genero"]);
    print(snapshot["valor"]);
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
    generoConvivente = map["genero"];
    quant = int.tryParse(map["quant"]);
    for (String imgs in map["imagens"]) {
      imgsLink.add(imgs);
    }
  }



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
        imgsFile.add(File(image.path));
      }
    }

    return imgsFile;
  }

  Future<List> _saveImgs() async {
    List imgUrls = [];
    for (var img in imgsFile) {
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
