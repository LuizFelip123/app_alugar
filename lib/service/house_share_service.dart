import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/repository/house_share_repository.dart';
import 'package:app_alugar/service/state_service.dart';
import 'package:app_alugar/service/user_service.dart';

class HouseShareService{
  final _houseShareRepository = HouseShareRepository();
  final _userService = UserService();
  final _stateService = StateService();
  Future<List<HouseShareModel>> getAllHouseShareModel () async{
    return await _houseShareRepository.getAll();
  }  
    save(HouseShareModel houseShareModel){
      _houseShareRepository.save(houseShareModel, _userService.getUserId() );
    }
  Future <List<HouseShareModel>> findByState(String text)async{
      return await _houseShareRepository.findByState(text);
  }
}