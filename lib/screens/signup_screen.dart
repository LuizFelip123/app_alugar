import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                onPressed: () {},
                child: Text(
                  "Cadastrar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
              ),
            ],
          )
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
        ],
      ),
    ));
  }
}
