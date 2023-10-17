import 'package:app_alugar/model/city_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CityService {
  final String _urlIBGE =
      "https://servicodados.ibge.gov.br/api/v1/localidades/estados";
  Future<List<CityModel>> getCitysByState(String? sigla) async {
    List<CityModel> citys = [];

    final uriCity = Uri.parse(_urlIBGE + "/${sigla}/municipios");
    final response = await http.get(uriCity);
    var jsonResponse = convert.jsonDecode(response.body) as List;
    for (int i = 0; i < jsonResponse.length; i++) {
      citys.add(CityModel.fromListIndex(jsonResponse, i));
    }
    return citys;
  }
}
