// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool inupdateing = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inupdateing,
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 31, 33, 62),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              Spacer(
                flex: 2,
              ),
              Center(
                child: Image.asset(
                  'images/chat-app.png',
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'LOGIN',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
              Spacer(
                flex: 1,
              ),
              TextField(
                onChanged: (date) {
                  email = date;
                },
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'EMAIL',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                    hintText: 'PASSWORD',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    inupdateing = true;
                    await loginuser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('login sucsessfuly😍'),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                  inupdateing = false;
                  setState(() {});
                  Navigator.pushNamed(context, 'chatpage', arguments: email);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white30),
                  width: 410,
                  height: 50,
                  child: Center(child: Text('login')),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "you aren't have account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'registerpage');
                    },
                    child: Text(
                      '   Register',
                      style: TextStyle(color: Colors.white38),
                    ),
                  ),
                ],
              ),
              Spacer(
                flex: 3,
              )
            ]),
          )),
    );
  }

  Future<void> loginuser() async {
    setState(() {});
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
