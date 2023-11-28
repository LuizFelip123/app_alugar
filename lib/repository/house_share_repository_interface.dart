import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';

abstract class IHouseShareRepository{
  Future save(HouseShareModel houseShareModel, String? idUser);
  Future delete(String id);
  Future<HouseShareModel> get( String id);
  Future update(HouseShareModel houseShareModel);
  Future<List<HouseShareModel>> getAll();
  Future<List<HouseShareModel>> findByState(String text);
  Future<List<HouseShareModel>> findByCity(String city, String state);
  Future<List<HouseShareModel>> findByUser( String? idUser);
  Future<List<UserModel>> findListInterested(String id);
}