import 'package:app_alugar/controller/house_share_controller.dart';
import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/screens/home_screen.dart';
import 'package:app_alugar/screens/widgets/custom_barra.dart';
import 'package:app_alugar/screens/titles/house_title.dart';
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
  void initState() {
    super.initState();
    _loadHouses();
  }

  _loadHouses()async{
   listHouseShareModel =  await widget._userController.getAllHouseShare();

   setState(() {
     listHouseShareModel;
   });
  }
   @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BarraBusca(_searchFirebase),
        Padding(padding: EdgeInsets.only(top: 20)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listHouseShareModel.length,
          itemBuilder: (context, index) {
            var data = listHouseShareModel[index].toMap();

            if (search.isEmpty ||
                data["cidade"]
                    .toString()
                    .toLowerCase()
                    .startsWith(search.toLowerCase())) {
              return HouseTitle(houseShareList[index]);
            }

            return Container();
          },
        ),
      ],
    );
  }


  _searchFireBase(String text) {
    setState(() {
      search = text;
    });
  }
}
