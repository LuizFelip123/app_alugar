import 'dart:ffi';

import 'package:app_alugar/controllers/localizacao_controller.dart';
import 'package:app_alugar/models/house_model.dart';
import 'package:app_alugar/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseRegisterScreen extends StatefulWidget {
  const HouseRegisterScreen({super.key});

  @override
  State<HouseRegisterScreen> createState() => _HouseRegisterScreenState();
}

class _HouseRegisterScreenState extends State<HouseRegisterScreen> {
  bool? shareHouse = false;
  List? _estados;
  List? _cidades;
  final controller = LocalizacaoController();
  String selectedValue = "Ambos Gênero";
  String selectedEstado = "Nenhum";
  String selectedCidade = "Nenhum";
  final _valorController = TextEditingController();
  final _descricaoController = TextEditingController();
  List<PickedFile>? _images;
  List<DropdownMenuItem<String>> menuCidade = [
    DropdownMenuItem(child: Text("Nenhum"), value: "Nenhum")
  ];

  List<DropdownMenuItem<String>> menuEstados = [
    DropdownMenuItem(child: Text("Nenhum"), value: "Nenhum")
  ];
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Homem"), value: "Homem"),
    DropdownMenuItem(child: Text("Mulher"), value: "Mulher"),
    DropdownMenuItem(child: Text("Ambos Gênero "), value: "Ambos Gênero"),
  ];
  @override
  void initState() {
    // TODO: implement initState

    controller.getStates().then((value) {
      _estados = value;
      for (int i = 0; i < _estados!.length; i++) {
        menuEstados.add(DropdownMenuItem(
            child: Text(_estados![i].nome.toString()),
            value: _estados![i].sigla.toString()));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastrar Casa",
          style: TextStyle(fontFamily: "times", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<HouseModel>(
        builder: (context, child, model) {
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: "Estado"),
                          items: menuEstados,
                          value: selectedEstado,
                          onChanged: (value) async {
                            setState(() {
                              if (value != null) {
                                selectedEstado = value;
                              }
                            });
                            if (value != "Nenhum") {
                              setState(() {
                                menuCidade.clear();
                                menuCidade.add(DropdownMenuItem(
                                    child: Text("Nenhum"), value: "Nenhum"));
                                selectedCidade = "Nenhum";
                              });
                              final cidades = await controller
                                  .getCitysForStats(selectedEstado);
                              await _initCidade(cidades);
                              setState(() {
                                menuCidade;
                              });
                            }
                          },
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
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _valorController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              label: Text("Valor do Alguel")),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _descricaoController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              label: Text("Descrição")),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "A casa será comparilhada?",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Checkbox(
                                checkColor: Colors.white,
                                side: BorderSide(width: 3, color: Colors.black),
                                value: shareHouse,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      shareHouse = value;
                                    });
                                  }
                                })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  _images =
                                      await ImagePicker.platform.pickMultiImage(
                                    imageQuality: 90,
                                  );
                                },
                                icon: Icon(Icons.photo_camera)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Selecionar Fotos da Casa",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        shareHouse != null && shareHouse == true
                            ? Column(
                                children: [
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: "Sexo do conviventes"),
                                    items: menuItems,
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != null) {
                                          selectedValue = value;
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        label: Text("Quantidade Vagas")),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  onPressed: () {
                    final imagesFormat = model.formatImagens(_images);
                    model.saveHouse({
                      "descricao": _descricaoController.text,
                      "valor": _valorController.text,
                      "imagens": imagesFormat,
                      "estado": selectedEstado,
                      "cidade": selectedCidade,
                      "user_id": UserModel.of(context).uid()
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                        fontFamily: "times",
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
