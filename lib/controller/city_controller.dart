import 'dart:collection';

import 'package:app_alugar/model/city_model.dart';

import 'package:app_alugar/service/city_service.dart';
import 'package:flutter/material.dart';

class CityController extends ChangeNotifier{
  final _cityService = CityService();
  List<CityModel> _citys = [];
  UnmodifiableListView<CityModel> get houses => UnmodifiableListView(_citys);
  Future<void> getCitysByState(String? sigla) async {
    _citys = await _cityService.getCitysByState(sigla);
  }
}
