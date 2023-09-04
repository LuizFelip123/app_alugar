import 'package:app_alugar/models/house_share_model.dart';
import 'package:app_alugar/models/user_model.dart';
import 'package:app_alugar/screens/titles/house_interested_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("houses")
                  .where('user_id', isEqualTo: UserModel.of(context).uid(),)
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
                      return HouseInterestedTitle(
                        HouseShareModel.fromSnapshot(snapshot.data!.docs[index]),
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
