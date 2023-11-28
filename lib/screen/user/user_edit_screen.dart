import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEditScreen extends StatefulWidget {


  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Editar Usuário",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true),
      body: ListView(
        children: [
      Consumer<UserController>(builder: (context, userController, child)  {

        _nameController.text =  userController.userModel.userData['name'] ;
        _emailController.text = userController.userModel.userData['email'];
        return Form(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.black,
                            ),
                          ),
                          label: Text(
                            "Nome",
                            style: TextStyle(color: Colors.black),
                          ),
                          focusColor: Colors.black),
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text!.isEmpty || !text.contains("@"))
                          return "Email inválido";
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.black,
                            ),
                          ),
                          label: Text(
                            "Email",
                            style: TextStyle(color: Colors.black),
                          ),
                          focusColor: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          );}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {

                Navigator.of(context).pop();
              },
              child: Text(
                "Editar",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
