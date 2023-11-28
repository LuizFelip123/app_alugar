import 'dart:collection';

import 'package:app_alugar/model/state_model.dart';
import 'package:app_alugar/service/state_service.dart';
import 'package:flutter/material.dart';

class StateController extends ChangeNotifier {
   final _stateService = StateService();

    Future<List<StateModel>> getAll() async {
    return  await _stateService.getStates();
    }
}