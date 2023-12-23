import 'dart:collection';

import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/service/house_share_service.dart';
import 'package:flutter/material.dart';

class HouseShareController extends ChangeNotifier {
  final _houseShareService = HouseShareService();
    String state = "";
    List<HouseShareModel> houses = [];
    List<HouseShareModel> findHouse = [];
    List<HouseShareModel> userHouses = [];
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
       getAllHouseShare();
       findHouse = [];
       find = false;
       notifyListeners();
     }else{
       state = text;
     findHouse = await  _houseShareService.findByState(text);
       houses = [];
       find = true;
     notifyListeners();
     }





   }
  findByCity(String city, String state) async{
   findHouse = await _houseShareService.findByCity(city, state);

   notifyListeners();
   }
  findByUser() async {
  userHouses =  await _houseShareService.findByUser();

  notifyListeners();
  }

  findListInterested(String id){
    _houseShareService.findListInterested(id);
  }
}