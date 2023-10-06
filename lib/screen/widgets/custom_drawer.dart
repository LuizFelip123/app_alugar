import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/login_screen.dart';
import 'package:app_alugar/screen/titles/drawer_title.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final pageController;
  CustomDrawer({required this.pageController});
  Widget _buildDrawerBack() => Container(
        color: Colors.black,
      );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    padding: EdgeInsets.fromLTRB(
                      0.0,
                      16.0,
                      16.0,
                      8.0,
                    ),
                    height: 170.0,
                    child: Stack(
                      children: [
                        const Positioned(
                          top: 8.0,
                          left: 0.0,
                          child: Text(
                            "Alugar House!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Olá, ${model.isLoggedIn() ? model.userData['name'] : ""}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (!model.isLoggedIn()) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    }
                                  },
                                  child: Text(
                                    !model.isLoggedIn()
                                        ? "Cadastre-se ou entre na sua conta"
                                        : "",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  DrawerTile(
                    icon: Icons.home,
                    text: "Início",
                    pageController: pageController,
                    page: 0,
                  ),
                  DrawerTile(
                    icon: Icons.assignment_ind,
                    text: "Meu Perfil",
                    pageController: pageController,
                    page: 1,
                  ),
            
                  model.isLoggedIn()
                      ? DrawerTile(
                        icon: Icons.output,
                        text: "Sair",
                        pageController: pageController,
                        page: null,
                      )
                      : Container(),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
