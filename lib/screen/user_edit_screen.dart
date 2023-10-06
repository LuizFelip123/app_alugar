import 'package:app_alugar/model/user_model.dart';
import 'package:flutter/material.dart';

class UserEditScreen extends StatefulWidget {
  final UserModel _userModel;
  UserEditScreen(this._userModel);

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController.text = widget._userModel.userData["name"];
    _emailController.text = widget._userModel.userData["email"];
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
          Form(
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
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                UserModel.of(context)
                    .updateUser(_emailController.text, _nameController.text);
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
