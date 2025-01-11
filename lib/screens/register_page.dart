import 'package:chat_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 31, 33, 62),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              const Spacer(
                flex: 2,
              ),
              Center(
                child: Image.asset(
                  'images/chat-app.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'REGISTER',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
              const Spacer(
                flex: 1,
              ),
              TextField(
                onChanged: (date) {
                  email = date;
                },
                style: const TextStyle(color: Colors.white70),
                decoration: const InputDecoration(
                  hintText: 'EMAIL',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (date) {
                  password = date;
                },
                style: const TextStyle(color: Colors.white70),
                decoration: const InputDecoration(
                    hintText: 'PASSWORD',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    isloading = true;
                    setState(() {});
                    await RegisterUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Welcome in our community😍'),
                      ),
                    );
                  } catch (ex) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          ex.toString(),
                        ),
                      ),
                    );
                  }
                  isloading = false;
                  setState(() {});
                  Navigator.pushNamed(context, 'chatpage', arguments: email);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white30),
                  width: 410,
                  height: 50,
                  child: const Center(child: Text('register')),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "you have an account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text(
                      '   login',
                      style: TextStyle(color: Colors.white38),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 3,
              )
            ]),
          )),
    );
  }

  Future<void> RegisterUser() async {
    var auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
