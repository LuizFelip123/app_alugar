import 'package:app_alugar/screens/tabs/house_list_tab.dart';
import 'package:app_alugar/screens/user_screen.dart';
import 'package:app_alugar/screens/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Houses",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: HouseListTab(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Tela Usuário",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: UserScreen(),
          drawer: CustomDrawer(pageController: _pageController),
        )
      ],
    );
  }
}
