import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/repository/house_share_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HouseShareRepository implements IHouseShareRepository {
  final CollectionReference _housesCollection =
      FirebaseFirestore.instance.collection('houses');
  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<HouseShareModel> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<HouseShareModel>> getAll() async {
    // TODO: implement getAll
    QuerySnapshot querySnapshot = await _housesCollection.get();
    List<HouseShareModel> houses = querySnapshot.docs
        .map((doc) => HouseShareModel.fromSnapshot(doc))
        .toList();
    for (var element in houses) {
      print(element.cidade);
    }
    print("Veio aqui");
    return houses;
  }

  @override
  Future save(HouseShareModel houseShareModel) async {
    await _saveImgs(houseShareModel.imgsFile).then((value) async {
      final urls = value;
      try {
        houseShareModel.houseData['imagens'] = urls;

        await FirebaseFirestore.instance
            .collection("houses")
            .doc()
            .set(houseShareModel.houseData);
      } catch (e) {
        print("Erro = $e");
      }
    });
  }

  @override
  Future update(HouseShareModel houseShareModel) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<List> _saveImgs(imgsFile) async {
    List imgUrls = [];
    for (var img in imgsFile) {
      Reference reference =  FirebaseStorage.instance.ref().child(DateTime.now().toString());
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
}
