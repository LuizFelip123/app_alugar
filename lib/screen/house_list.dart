import 'package:app_alugar/controller/house_share_controller.dart';
import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/screen/home_screen.dart';
import 'package:app_alugar/screen/widgets/custom_barra.dart';
import 'package:app_alugar/screen/titles/house_title.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HouseList extends StatefulWidget {
  HouseShareController _userController = HouseShareController();
   HouseList({super.key});


  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  String search = "";
  late List<HouseShareModel> listHouseShareModel;
  
   @override
  void initState()async {
    super.initState();
     _loadHouses();
  }

  _loadHouses() async{
   listHouseShareModel =  await widget._userController.getAllHouseShare();

   setState(() {
     listHouseShareModel;
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



