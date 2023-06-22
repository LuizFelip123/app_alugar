import 'package:app_alugar/models/house_model.dart';
import 'package:app_alugar/models/house_share_model.dart';
import 'package:app_alugar/models/user_model.dart';
import 'package:app_alugar/screens/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HouseScreen extends StatefulWidget {
  final HouseModel _houseModel;

  HouseScreen(this._houseModel);

  @override
  State<HouseScreen> createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  HouseShareModel? houseShareModel;
  @override
  Widget build(BuildContext context) {
    if (widget._houseModel.shareHouse == true) {
      houseShareModel = widget._houseModel as HouseShareModel;
    }
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
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(widget._houseModel.descricao!),
                SizedBox(
                  height: 18.0,
                ),
                widget._houseModel.shareHouse == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apenas : " + houseShareModel!.genero!,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "vagas : " + houseShareModel!.quant.toString(),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      )
                    : Container(),
                !UserModel.of(context).isLoggedIn()
                    ? ElevatedButton(
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
                          ;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: Text(
                          "Realizar Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          final update = await widget._houseModel
                              .addInterested(UserModel.of(context).uid());
                          if (update) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Demostração de Interesse realizado!",
                                  style: TextStyle(color: Colors.white)),
                              duration: Duration(
                                seconds: 2,
                              ),
                              backgroundColor: Colors.black,
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Falha ao demostrar interesse na casa!",
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
                        child: Text(
                          "Demostrar interesse",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: UserModel.of(context).isLoggedIn()
          ? FloatingActionButton(
              onPressed: () {
                UserModel.of(context)
                    .addFavorite(widget._houseModel.cid!)
                    .then((value) {
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
                });
              },
              backgroundColor: Colors.black,
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
