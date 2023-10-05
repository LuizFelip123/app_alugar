import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/repository/house_share_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HouseShareRepository  extends IHouseShareRepository{
  final CollectionReference _housesCollection = FirebaseFirestore.instance.collection('houses');
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
      return houses;
  }

  @override
  Future save(HouseShareModel houseShareModel) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future update(HouseShareModel houseShareModel) {
    // TODO: implement update
    throw UnimplementedError();
  }

}