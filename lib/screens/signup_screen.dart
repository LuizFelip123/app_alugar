import 'package:app_alugar/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? hire = true;
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/login/signup-fundo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          ScopedModelDescendant<UserModel>(builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Center(
              child: ListView(
                padding: EdgeInsets.only(top: 100),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.deepPurple,
                      ),
                      _form(),
                      ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "hide": hire,
                            "interested":[]
                          };
                          model.signup(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        },
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
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
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                label: Text(
                  "Nome",
                  style: TextStyle(color: Colors.white),
                ),
                focusColor: Colors.white),
          ),
          TextFormField(
            validator: (text) {
              if (text!.isEmpty || !text.contains("@")) return "Email inválido";
            },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                label: Text(
                  "Email",
                  style: TextStyle(color: Colors.white),
                ),
                focusColor: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passController,
            style: TextStyle(color: Colors.white),
            obscureText: true,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                label: Text(
                  "Senha",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Você Está Buscando Casa?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Checkbox(
                  checkColor: Colors.white,
                  side: BorderSide(width: 3, color: Colors.white),
                  value: hire,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        hire = value;
                      });
                    }
                  })
            ],
          )
        ],
      ),
    ));
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
