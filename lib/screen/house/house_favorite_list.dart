import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/user/login_screen.dart';
import 'package:app_alugar/screen/titles/favorite_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseFavoriteList extends StatefulWidget {
  UserController userController = UserController();

  HouseFavoriteList({super.key});

  @override
  State<HouseFavoriteList> createState() => _HouseFavoriteListState();
}

class _HouseFavoriteListState extends State<HouseFavoriteList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.userController = Provider.of<UserController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return widget.userController.isLogin == false
        ? Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.highlight_remove_sharp,
            color: Colors.black,
            size: 80.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            "Para usar a tela do usuário é necessário realizar o login!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
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
            },
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    )
        : Column(
      children: [
        widget.userController.userModel.favorites.length == 0
            ? Center(
          child: Text(
            "Não há Casas Salvas",
            style:
            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          itemCount: widget.userController.userModel.favorites.length,
          itemBuilder: (context, index) {
            return FavoriteTitle(
                widget.userController.userModel.favorites[index]);
          },
        ),
      ],
    );


  }
}
