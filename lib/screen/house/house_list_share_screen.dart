import 'package:app_alugar/controller/house_share_controller.dart';
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/screen/titles/house_title.dart';
import 'package:app_alugar/screen/widgets/custom_barra.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseListShareScreen extends StatefulWidget {
   late HouseShareController _houseShareController = HouseShareController();

   HouseListShareScreen({super.key});

  @override
  State<HouseListShareScreen> createState() => _HouseListShareScreenState();
}

class _HouseListShareScreenState extends State<HouseListShareScreen> {
 String search = "";

  
   @override
  void initState() {
    super.initState();
      widget._houseShareController = Provider.of<HouseShareController>(context, listen: false);
     _loadHouses();
  }

  _loadHouses() async {
    await widget._houseShareController.getAllHouseShare();
  }
   @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BarraBusca( searchFireBase),
        Padding(padding: EdgeInsets.only(top: 20)),
        Consumer<HouseShareController>(builder:(context, houseshare, child){
          return houseshare.houses.isEmpty ? Container( child: Center(child: Text("Está vazia o lista"),),) : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:houseshare.houses.length,
          itemBuilder: (_, index) {
          
              return HouseTitle(houseshare.houses[index]);
        
          
          },
          );
        } ),
      ],
    );
  }


  searchFireBase(String text) {
    setState(() {
      search = text;
    });
  }
}
