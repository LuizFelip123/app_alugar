import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/titles/house_interested_title.dart';
import 'package:app_alugar/screen/user/login_screen.dart';
import 'package:app_alugar/screen/titles/favorite_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseFavoriteList extends StatefulWidget {


const  HouseFavoriteList({super.key});

  @override
  State<HouseFavoriteList> createState() => _HouseFavoriteListState();
}

class _HouseFavoriteListState extends State<HouseFavoriteList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<UserController>(

            builder: (context, userController, child) {
              if(!userController.isLogin){
                 return  Container(
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
                       const   Text(
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
                             ;
                           },
                           child: const Text(
                             "Login",
                             style: TextStyle(
                                 color: Colors.black, fontWeight: FontWeight.bold),
                           ))
                     ],
                   ),
                 );
              }
              if (userController.userModel.favorites.isEmpty ) {
                return const  Center(
                  child: Text(
                    "Sem casas no favorito!",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return ListView(children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userController.userModel.favorites.length,
                  itemBuilder: (context, index) {
                    return FavoriteTitle(
                      userController.userModel.favorites[index],
                    );
                  },
                )
              ]);
            },
          ),
        ),
      ],
    );
  }
}
