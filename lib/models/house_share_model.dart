import 'package:cloud_firestore/cloud_firestore.dart';

import 'house_model.dart';

class HouseShareModel extends HouseModel {
  String? _generoConvivente;
  int? _quant;
  HouseShareModel();
  HouseShareModel.fromSnapshot(DocumentSnapshot snapshot) {
    cid = snapshot.id;
    cidade = snapshot['cidade'];
    descricao = snapshot['descricao'];
    estado = snapshot['estado'];
    valor = double.parse(snapshot['valor']);
    interested = snapshot["interested"];
    _generoConvivente = snapshot["genero"];
    _quant = int.tryParse(snapshot["quant"]);
    for (String imgs in snapshot["imagens"]) {
      imgsLink.add(imgs);
    }
  }
  HouseShareModel.fromMap(Map<String, dynamic> map){
    cid = map['id'];
    cidade = map['cidade'];
    descricao = map['descricao'];
    estado = map['estado'];
    valor = double.parse(map['valor']);
    interested = map["interested"];
    _generoConvivente = map["genero"];
    _quant = int.tryParse(map["quant"]);
    for (String imgs in map["imagens"]) {
      imgsLink.add(imgs);
    }
  }
}
