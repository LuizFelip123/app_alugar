import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/repository/house_share_repository.dart';
import 'package:app_alugar/service/house_share_service.dart';

class HouseShareController {
  HouseShareService _houseShareService = HouseShareService();
  Future<List<HouseShareModel>> getAllHouseShare()async {
    return await  _houseShareService.getAllHouseShareModel();
  }

}