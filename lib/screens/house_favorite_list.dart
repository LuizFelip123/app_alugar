import 'package:app_alugar/models/house_model.dart';
import 'package:app_alugar/models/user_model.dart';
import 'package:app_alugar/screens/login_screen.dart';
import 'package:app_alugar/screens/titles/house_title.dart';
import 'package:app_alugar/screens/titles/myhouse_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseFavoriteList extends StatefulWidget {
  const HouseFavoriteList({super.key});

  @override
  State<HouseFavoriteList> createState() => _HouseFavoriteListState();
}

class _HouseFavoriteListState extends State<HouseFavoriteList> {
  @override
  Widget build(BuildContext context) {
    return !UserModel.of(context).isLoggedIn()
        ? Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.highlight_remove_sharp,
                  color: Colors.black,
                  size: 80.0,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Para usar a tela do usuário é necessário realizar o login!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                          .then((value) {
                        setState(() {});
                      });
                      ;
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )
        : ScopedModelDescendant<UserModel>(builder: (context, child, model) {
            return ListView.builder(
              itemCount: model.favorites.length,
              itemBuilder: (context, index) {
                return HouseTitle(model.favorites[index]);
              },
            );
          });
  }
}
