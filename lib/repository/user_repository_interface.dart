import 'package:app_alugar/model/user_model.dart';

abstract class IUserRepository{
  Future save(UserModel userModel);
  Future delete(String id);
  Future<UserModel> get( String id);
  Future update(UserModel userModel);
}