
import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/house_share_model.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/titles/interested_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InterestedScreen extends StatelessWidget {
  final HouseShareModel _houseModel;

  InterestedScreen(this._houseModel);

  @override
  Widget build(BuildContext context) {
    final  userController =  Provider.of<UserController>(context, listen: false);
    userController.userInterested(_houseModel.interested);

      return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Interessados",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<UserController>(

              builder: (context, contreller, snapshot) {

                if (contreller.interested.isEmpty) {
                  return const Center(
                    child:Text(
                      "Sem Usuários interessados",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                return ListView(children: [
                const  Padding(padding: EdgeInsets.only(top: 20)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contreller.interested.length ,
                    itemBuilder: (context, index) {
               return InterestedTitle(
                          contreller.interested[index]);
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
