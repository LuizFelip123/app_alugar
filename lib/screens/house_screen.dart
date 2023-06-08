import 'package:app_alugar/models/house_model.dart';
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
                            // Após retornar da tela de login, chama o setState para reconstruir a tela
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
                        onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
