import 'package:app_alugar/controller/city_controller.dart';
import 'package:app_alugar/controller/localizacao_controller.dart';
import 'package:app_alugar/controller/state_controller.dart';
import 'package:flutter/material.dart';

class CustomSelect extends StatefulWidget {
  CustomSelect({ required this.name, required this.search});
  String name;
  Function(String text) search;
  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  List? itens;

  final controller = LocalizacaoController();

  final cityController = CityController();

  final stateController = StateController();

  String selectedValue = "Ambos Gênero";

  String selectedEstado = "Nenhum";

  List<DropdownMenuItem<String>> menu = [
    DropdownMenuItem(child: Text("Nenhum"), value: "Nenhum")
  ];

  @override
  void initState(){
    stateController.getStates().then((value) {
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
    return  DropdownButtonFormField(
      decoration: InputDecoration(labelText: widget.name),
      items: menu,
      value: selectedEstado,
      onChanged: (value)  async {
       if(value != null){
        await widget.search(value!);
       }
      }
    );
  }
}
