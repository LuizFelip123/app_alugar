import 'package:app_alugar/screens/house_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HouseListTab extends StatelessWidget {
  const HouseListTab({super.key});

  @override
  Widget build(BuildContext context) {
  return CupertinoTabScaffold(
      
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Buscar"
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: "Cadastrar"
          ),
        ],
      ),
      tabBuilder: (context, index){
              return HouseList();
      },
    );
  }  }


