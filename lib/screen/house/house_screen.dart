import 'dart:ffi';

import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/user/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseScreen extends StatefulWidget {
  final HouseShareModel _houseModel;

  HouseScreen(this._houseModel);

  @override
  State<HouseScreen> createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  HouseShareModel? houseShareModel;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Casa",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
              aspectRatio: 1.0,
              child: CarouselSlider(
                items: widget._houseModel.imgsLink.map((e) {
                  return Container(
                      decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(e),
                      fit: BoxFit.cover,
                    ),
                  ));
                }).toList(),
                options: CarouselOptions(
                  height: double
                      .infinity, // Preenche todo espaço vertical disponível
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                ),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Casa em " + widget._houseModel.cidade!,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "Valor de Aluguel: R\$ ${widget._houseModel.valor!.toStringAsFixed(2).replaceAll('.', ",")}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
               const  SizedBox(
                  height: 10.0,
                ),
                Text(widget._houseModel.descricao!),
               const SizedBox(
                  height: 18.0,
                ),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apenas : " + widget._houseModel!.generoConvivente!,
                          ),
                         const  SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "vagas : " + widget._houseModel!.quant.toString(),
                          ),
                         const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      )
                    ,
                Consumer<UserController>( builder: (context, userController, child) {
                 if(!userController.isLogin){
                   return ElevatedButton(
                     onPressed: () {
                       Navigator.of(context)
                           .push(
                         MaterialPageRoute(
                           builder: (context) => LoginScreen(),
                         ),
                       )
                           .then((_) {
                         setState(() {});
                       });

                     },
                     style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.black),
                     child: const Text(
                       "Realizar Login",
                       style: TextStyle(
                         color: Colors.white,
                       ),
                     ),
                   );
                 }
                 return  ElevatedButton(
                   onPressed: () async {
                     final update = await
                     userController.addInterested(widget._houseModel);
                       if (update) {
                    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                         content: Text(
                             "Demonstração de Interesse realizado!",
                             style: TextStyle(color: Colors.white)),
                         duration: Duration(
                           seconds: 2,
                         ),
                         backgroundColor: Colors.black,
                       ));
                     } else {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                         content: Text(
                             "Falha ao demonstrar interesse na casa!",
                             style: TextStyle(color: Colors.white)),
                         duration: Duration(
                           seconds: 2,
                         ),
                         backgroundColor: Colors.black,
                       ));
                     }
                   },
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.black),
                   child: const Text(
                     "Demonstrar interesse",
                     style: TextStyle(
                       color: Colors.white,
                     ),
                   ),
                 );
                },)
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<UserController>(builder: (context, controller, child) {
        if(controller.isLogin){
          return FloatingActionButton(
            onPressed: () {
             controller.addFavorite(widget._houseModel);
              bool value = false;
              print("Verificar o valor se adicionou : $value");
              if (value == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Casa Adicionado nos Favoritos!",
                      style: TextStyle(color: Colors.white)),
                  duration: Duration(
                    seconds: 2,
                  ),
                  backgroundColor: Colors.black,
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Falha ao salvar casa!",
                      style: TextStyle(color: Colors.white)),
                  duration: Duration(
                    seconds: 2,
                  ),
                  backgroundColor: Colors.black,
                ));
              }
            },
            backgroundColor: Colors.black,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          );
        }
        return Container();
      },)
    );
  }
}
