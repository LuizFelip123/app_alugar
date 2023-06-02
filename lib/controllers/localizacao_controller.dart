import 'package:http/http.dart' as http;


class LocalizacaoController{
String urlIBGE = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"; 
 estados() async {

      final uri = Uri.parse(urlIBGE);
      final response = await http.get(uri);
      print(response.body);
     
  }

 
  
}