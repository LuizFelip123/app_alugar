import 'dart:collection';

import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/service/house_share_service.dart';
import 'package:flutter/material.dart';

class HouseShareController extends ChangeNotifier {
  final _houseShareService = HouseShareService(); 
    List<HouseShareModel> _houses = [];
    UnmodifiableListView<HouseShareModel> get houses => UnmodifiableListView(_houses); 
   Future<void> getAllHouseShare() async {
    _houses = await  _houseShareService.getAllHouseShareModel();
    notifyListeners();
  }

}