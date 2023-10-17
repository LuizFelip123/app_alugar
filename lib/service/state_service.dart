import 'package:app_alugar/model/state_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class StateService {
 final  String _urlIBGE = "https://servicodados.ibge.gov.br/api/v1/localidades/estados";

  Future<List<StateModel>> getStates() async {
    List<StateModel> states = [];
    final uri = Uri.parse(_urlIBGE);
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
}
