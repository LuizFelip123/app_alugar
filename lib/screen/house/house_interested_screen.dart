import 'package:app_alugar/controller/house_share_controller.dart';

import 'package:app_alugar/screen/titles/house_interested_title.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseInterestedScreen extends StatefulWidget {
  const HouseInterestedScreen({super.key});

  @override
  State<HouseInterestedScreen> createState() => _HouseInterestedScreenState();
}

class _HouseInterestedScreenState extends State<HouseInterestedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Usuários Interessados",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<HouseShareController>(

              builder: (context, houseShare, child) {

                if (houseShare.userHouses.isEmpty ) {
                  return const  Center(
                    child: Text(
                      "Erro ao carregar os dados!",
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
                      return HouseInterestedTitle(
                        houseShare.userHouses[index],
                      );
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
}
