import 'package:app_alugar/model/house_share_model.dart';

abstract class IHouseShareRepository{
  Future save(HouseShareModel houseShareModel, String? idUser);
  Future delete(String id);
  Future<HouseShareModel> get( String id);
  Future update(HouseShareModel houseShareModel);
  Future<List<HouseShareModel>> getAll();
  Future<List<HouseShareModel>> findByState(String text);
}