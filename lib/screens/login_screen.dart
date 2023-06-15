import 'package:app_alugar/models/user_model.dart';
import 'package:app_alugar/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tela de Login",
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
              return Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                child: Center(
                  
                  child: CircularProgressIndicator(),
                ),
              );
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 11),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.black,
                      ),
                      _form(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            model.signin(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                        },
                        child: Text(
                          "Cadastrar-se",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(label: Text("Email")),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(label: Text("Senha")),
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
  }
 
  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!", style: TextStyle(color: Colors.white)),
      duration: Duration(
        seconds: 2,
      ),
      backgroundColor: Colors.black,
    ));
  }
}
