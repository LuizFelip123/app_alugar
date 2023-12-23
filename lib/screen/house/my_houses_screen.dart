import 'package:app_alugar/controller/house_share_controller.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/titles/myhouse_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHousesScreen extends StatefulWidget {
  const MyHousesScreen({super.key});

  @override
  State<MyHousesScreen> createState() => _MyHousesScreenState();
}

class _MyHousesScreenState extends State<MyHousesScreen> {
  HouseShareController houseShareController = HouseShareController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     houseShareController = Provider.of<HouseShareController>(context, listen: false);
    houseShareController.findByUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text(
          "Minhas Casas",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<HouseShareController>(

              builder: (context, houseShare, child) {


                if (houseShare.userHouses.isEmpty) {
                  return const Center(
                    child: Text(
                      "Não tem dados cadastrados!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return ListView(children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: houseShare.userHouses.length,
                    itemBuilder: (context, index) {

                      return MyHouseTitle(houseShare.userHouses[index], _delete);
                    },
                  )
                ]);
              },
            ),
          ),
        ],
      ),
    );
  }

  _delete(_houseModel, context)async {
    await UserModel.of(context).deleteHouse(_houseModel.cid, _houseModel.imgsLink);

    setState(() {

    });
  }
}
