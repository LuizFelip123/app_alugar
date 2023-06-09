import 'package:app_alugar/models/house_model.dart';
import 'package:app_alugar/models/user_model.dart';
import 'package:app_alugar/screens/titles/house_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHousesScreen extends StatefulWidget {
  const MyHousesScreen({super.key});

  @override
  State<MyHousesScreen> createState() => _MyHousesScreenState();
}

class _MyHousesScreenState extends State<MyHousesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
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
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("houses")
                  .where('user_id', isEqualTo: UserModel.of(context).uid())
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar os dados!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "Não tem dados cadastrados!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return ListView(children: [
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
            ),
          ),
        ],
      ),
    );
  }
}
