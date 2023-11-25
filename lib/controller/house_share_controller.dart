import 'dart:collection';

import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/service/house_share_service.dart';
import 'package:flutter/material.dart';

class HouseShareController extends ChangeNotifier {
  final _houseShareService = HouseShareService();

    List<HouseShareModel> houses = [];
    List<HouseShareModel> findHouse = [];
    bool  find = false;
   Future<void> getAllHouseShare() async {
    houses = await  _houseShareService.getAllHouseShareModel();

    notifyListeners();
    }
   save(HouseShareModel houseShareModel){
     _houseShareService.save( houseShareModel);
    notifyListeners();
   }
  findByState (String text ) async  {
      print(text);
     if(text == "Nenhum"){
       find = false;
       notifyListeners();
     }else{
     findHouse = await  _houseShareService.findByState(text);
       houses = [];
       find = true;
     notifyListeners();
     }





   }

}