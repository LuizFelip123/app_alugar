import 'package:app_alugar/models/house_share_model.dart';
import 'package:app_alugar/screens/titles/house_title.dart';
import 'package:app_alugar/screens/widgets/custom_barra.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HouseListShareScreen extends StatefulWidget {
  const HouseListShareScreen({super.key});

  @override
  State<HouseListShareScreen> createState() => _HouseListShareScreenState();
}

class _HouseListShareScreenState extends State<HouseListShareScreen> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("houses")
          .where('shareHouse', isEqualTo: true)
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
                    HouseShareModel.fromSnapshot(snapshot.data!.docs[index]));
              }
              if (data["cidade"]
                  .toString()
                  .toLowerCase()
                  .startsWith(search.toLowerCase())) {
                return HouseTitle(HouseShareModel.fromMap(data));
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
