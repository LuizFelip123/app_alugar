import 'package:app_alugar/controller/city_controller.dart';
import 'package:app_alugar/controller/house_share_controller.dart';
import 'package:app_alugar/controller/state_controller.dart';
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/screen/titles/house_title.dart';
import 'package:app_alugar/screen/widgets/custom_barra.dart';

import 'package:app_alugar/screen/widgets/custom_select.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseListShareScreen extends StatefulWidget {


  const HouseListShareScreen({super.key});

  @override
  State<HouseListShareScreen> createState() => _HouseListShareScreenState();
}

class _HouseListShareScreenState extends State<HouseListShareScreen> {
  String state ="";
  HouseShareController _houseShareController = HouseShareController();
  final cityController = CityController();

  @override
  void initState() {
    super.initState();
    _houseShareController = Provider.of<HouseShareController>(context, listen: false);
    _loadHouses();
  }

  _loadHouses() async {
    await _houseShareController.getAllHouseShare();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomSelect(name: "Estado", search: searchFireBase, searchCity: searchCity,),
        ),

        const Padding(padding: EdgeInsets.only(top: 20)),
        Consumer<HouseShareController>(builder: (context, houseShare, child) {


          print("pasoou daqui - ${houseShare.findHouse!.length}");

          print("pasoou daqui - ${houseShare.findHouse}");

          print("Lista - ${houseShare.houses.length}");

          if (houseShare.find != true) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: houseShare.houses.length,
              itemBuilder: (_, index) {
                return HouseTitle(houseShare.houses[index]);
              },
            );
          }


          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: houseShare.findHouse!.length,
            itemBuilder: (_, index) {
              return HouseTitle(houseShare.findHouse![index]);
            },
          );
        }),
      ],
    );
  }

  searchFireBase(String estado)  async {
    if(estado!= ""  ) {
      _houseShareController.findByState(estado);
      await cityController.getCitysByState(estado);
    }else{

    }

  }

  searchCity(String estado, String city)  {


      _houseShareController.findByCity(city, estado);


  }

}
