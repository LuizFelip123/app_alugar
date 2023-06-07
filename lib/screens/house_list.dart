import 'package:app_alugar/models/house_model.dart';
import 'package:app_alugar/screens/home_screen.dart';
import 'package:app_alugar/screens/widgets/custom_barra.dart';
import 'package:app_alugar/screens/titles/house_title.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HouseList extends StatelessWidget {
  const HouseList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("houses").get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(children: [
          BarraBusca(),
          Padding(padding: EdgeInsets.only(top: 20)),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return HouseTitle(
                  HouseModel.fromSnapshot(snapshot.data!.docs[index]));
            },
          )
        ]);
      },
    );
  }
}
