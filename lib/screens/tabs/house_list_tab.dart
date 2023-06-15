import 'package:app_alugar/screens/house_favorite_list.dart';
import 'package:app_alugar/screens/house_list.dart';
import 'package:app_alugar/screens/house_list_share_screen.dart';
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
              icon: Icon(CupertinoIcons.home), label: "Casa"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_3),
              label: "Alguel compartilhado"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bookmark_fill), label: "Salvos"),
        ],
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return HouseList();
        } else if (index == 1) {
          return HouseListShareScreen();
        } else {
          return HouseFavoriteList();
        }
      },
    );
  }
}
