import 'package:app_alugar/controller/house_share_controller.dart';
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/screen/titles/house_title.dart';
import 'package:app_alugar/screen/widgets/custom_barra.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HouseListShareScreen extends StatefulWidget {
   HouseShareController _userController = HouseShareController();

   HouseListShareScreen({super.key});

  @override
  State<HouseListShareScreen> createState() => _HouseListShareScreenState();
}

class _HouseListShareScreenState extends State<HouseListShareScreen> {
 String search = "";
  late List<HouseShareModel> listHouseShareModel = [];
  
   @override
  void initState() {
    super.initState();
     _loadHouses();
  }

  _loadHouses() {
    widget._userController.getAllHouseShare().then((value){
      setState(() {
        listHouseShareModel = value;
      });
    });
  }
   @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BarraBusca( searchFireBase),
        Padding(padding: EdgeInsets.only(top: 20)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listHouseShareModel.length,
          itemBuilder: (context, index) {
          

            if (listHouseShareModel.isNotEmpty ) {
              return HouseTitle(listHouseShareModel[index]);
            }

            return Container();
          },
        ),
      ],
    );
  }


  searchFireBase(String text) {
    setState(() {
      search = text;
    });
  }
}
