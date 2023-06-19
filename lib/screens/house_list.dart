import 'package:app_alugar/models/house_model.dart';
import 'package:app_alugar/screens/home_screen.dart';
import 'package:app_alugar/screens/widgets/custom_barra.dart';
import 'package:app_alugar/screens/titles/house_title.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HouseList extends StatefulWidget {
  const HouseList({super.key});

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("houses").where('shareHouse', isEqualTo: false)
          .orderBy("valor", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(children: [
          BarraBusca(_searchFireBase),
          Padding(padding: EdgeInsets.only(top: 20)),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              if (search.isEmpty) {
                return HouseTitle(
                    HouseModel.fromSnapshot(snapshot.data!.docs[index]));
              }
              if (data["cidade"]
                  .toString()
                  .toLowerCase()
                  .startsWith(search.toLowerCase())) {
                return HouseTitle(HouseModel.fromMap(data));
              }
              return Container();
            },
          )
        ]);
      },
    );
  }

  _searchFireBase(String text) {
    setState(() {
      search = text;
    });
  }
}
