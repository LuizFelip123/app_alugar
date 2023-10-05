import 'package:app_alugar/model/city_model.dart';
import 'package:app_alugar/model/state_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocalizacaoController {
  String urlIBGE =
      "https://servicodados.ibge.gov.br/api/v1/localidades/estados";

  static final LocalizacaoController _singleton =
      LocalizacaoController._internal();
  LocalizacaoController._internal();

  factory LocalizacaoController() {
    return _singleton;
  }
  Future<List<StateModel>> getStates() async {
    List<StateModel> states = [];
    final uri = Uri.parse(urlIBGE);
    final response = await http.get(uri);
    var jsonResponse = convert.jsonDecode(response.body) as List;
    for (int i = 0; i < jsonResponse.length; i++) {
      states.add(StateModel.fromListIndex(jsonResponse, i));
    }
    states.sort((a, b) => a.nome!.compareTo(b.nome!));
    for (StateModel state in states) {
      print(state.nome);
    }
    return states;
  }
  Future<List<CityModel>> getCitysForStats(String? sigla) async {
    List<CityModel> citys = [];

       final uriCity  =     Uri.parse(urlIBGE + "/${sigla}/municipios");
     final response = await http.get(uriCity);
    var jsonResponse = convert.jsonDecode(response.body) as List;
for (int i = 0; i < jsonResponse.length; i++) {
      citys.add(CityModel.fromListIndex(jsonResponse, i));
    }
    return citys;
  }
}
