import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/repository/house_share_repository.dart';

class HouseShareService{
  final _houseShareRepository = HouseShareRepository();

  Future<List<HouseShareModel>> getAllHouseShareModel () async{
    return await _houseShareRepository.getAll();
  }  

}