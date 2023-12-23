import 'package:app_alugar/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastrar",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ScopedModelDescendant<UserModel>(builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Center(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 13)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.black,
                      ),
                      _form(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "favorite":[],
                              "interested": []
                            };
                            model.signup(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          },
                          child:  Text(
                            "Cadastrar",
                            style:   TextStyle(
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
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
      child: Padding(
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
            TextFormField(
              controller: _passController,
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  label: Text(
                    "Senha",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
    
          ],
        ),
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Falha ao Entrar!",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(
        seconds: 2,
      ),
      backgroundColor: Colors.black,
    ));
  }
}
