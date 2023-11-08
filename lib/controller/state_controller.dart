import 'dart:collection';

import 'package:app_alugar/model/state_model.dart';
import 'package:app_alugar/service/state_service.dart';
import 'package:flutter/material.dart';

class StateController extends ChangeNotifier {
   final _stateService = StateService();
   List<StateModel> _states = [];
  UnmodifiableListView<StateModel> get houses => UnmodifiableListView(_states);
    Future<List<StateModel>> getStates() async {
    return  await _stateService.getStates();
    }
}