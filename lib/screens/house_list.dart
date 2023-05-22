import 'package:app_alugar/screens/widgets/custom_barra.dart';
import 'package:app_alugar/screens/titles/house_title.dart';
import 'package:flutter/material.dart';

class HouseList extends StatelessWidget {
  const HouseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BarraBusca(),
        Padding(padding: EdgeInsets.only(top: 20)),
        HouseTitle(),
        HouseTitle(),
      ],
    );
  }
}
