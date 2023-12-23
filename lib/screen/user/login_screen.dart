import 'package:app_alugar/controller/house_share_controller.dart';
import 'package:app_alugar/controller/user_controller.dart';
import 'package:app_alugar/model/user_model.dart';
import 'package:app_alugar/screen/user/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {

  State<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen> {
  UserController  _userController = UserController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _userController   = Provider.of<UserController>(context, listen: false);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
     Consumer<UserController>(builder: (context, userController, child) {
            if (userController.userModel.isLoading)
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
                     const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.black,
                      ),
                      _form(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () async{
                           await _userController.signin(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          },
                          child: const  Text(
                            "Login",
                            style:  TextStyle(
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
                        child: const Text(
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
              decoration: const InputDecoration(label: Text("Email")),
            ),
           const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(label: Text("Senha")),
            ),
           const SizedBox(
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
    ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
      content: Text("Falha ao Entrar!", style: TextStyle(color: Colors.white)),
      duration: Duration(
        seconds: 2,
      ),
      backgroundColor: Colors.black,
    ));
  }
}
