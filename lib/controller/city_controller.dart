import 'dart:collection';

import 'package:app_alugar/model/city_model.dart';

import 'package:app_alugar/service/city_service.dart';
import 'package:flutter/material.dart';

class CityController extends ChangeNotifier{
  final _cityService = CityService();
  List<CityModel> citys = [];
  Future<List<CityModel>> getCitysByState(String? sigla) async {
    citys = await _cityService.getCitysByState(sigla);
  return citys;
  }
}
