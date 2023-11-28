import 'package:app_alugar/controller/city_controller.dart';
import 'package:app_alugar/controller/localizacao_controller.dart';
import 'package:app_alugar/controller/state_controller.dart';
import 'package:flutter/material.dart';

class CustomSelect extends StatefulWidget {
  CustomSelect({ required this.name, required this.searchCity, required this.search});
  String name;
  Function(String text, String state) searchCity;
  Function(String text) search;
  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  List? itens;
  List? _cidades;
  final controller = LocalizacaoController();

  final cityController = CityController();

  final stateController = StateController();
  String selectedCidade = "Nenhum";
  String selectedValue = "Ambos Gênero";

  String selectedEstado = "Nenhum";

  List<DropdownMenuItem<String>> menu = [
    DropdownMenuItem(child: Text("Nenhum"), value: "Nenhum")
  ];
  List<DropdownMenuItem<String>> menuCidade = [
    DropdownMenuItem(child: Text("Nenhum"), value: "Nenhum")
  ];

  @override
  void initState(){
    stateController.getAll().then((value) {
      itens = value;
      for (int i = 0; i < itens!.length; i++) {
        print(itens![i].nome.toString());
        menu.add(DropdownMenuItem(
            child: Text(itens![i].nome.toString()),
            value: itens![i].sigla.toString()));
      }
    });

    }

  @override
   build(BuildContext context) {
    return  Column(
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(labelText: widget.name),
          items: menu,
          value: selectedEstado,
          onChanged: (value)  async {

            setState(() {
              if (value != null) {
                selectedEstado = value;
                widget.search(selectedEstado);
              }
            });
            if (value != "Nenhum") {
              setState(() {
                menuCidade.clear();
                menuCidade.add(DropdownMenuItem(
                    child: Text("Nenhum"), value: "Nenhum"));
                selectedCidade = "Nenhum";
              });
              final cidades = await cityController.getCitysByState(selectedEstado);
              await _initCidade(cidades);
              setState(() {
                menuCidade;
              });
            }
          }
        ),
        SizedBox(
          height: 30,
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(labelText: "Cidade"),
          items: menuCidade,
          value: selectedCidade,
          onChanged: (value) {

            setState(() {
              if (value != null) {
                selectedCidade = value;
                widget.searchCity(selectedEstado, selectedCidade);
              }
            });
          },
        ),

      ],
    );
  }
  _initCidade(value) {
    _cidades = value;
    for (int i = 0; i < _cidades!.length; i++) {
      menuCidade.add(DropdownMenuItem(
          child: Text(_cidades![i].nome.toString()),
          value: _cidades![i].nome.toString()));
    }
  }
}
