
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';

abstract class IUserRepository{
  Future save(UserModel userModel);
  Future delete(String id);
  Future<UserModel> get( String id);
  update(String email, String name,  String id );
  Future<List<UserModel>> getInterested(List ids);
  Future<HouseShareModel> getFavorite(String id);
  Future<bool> addInterested(HouseShareModel houseShareModel, String id);
  deleteFavorite(String id,UserModel  userModel , HouseShareModel houseShareModel);
}