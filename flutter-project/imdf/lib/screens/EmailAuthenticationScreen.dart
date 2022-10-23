import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'MainScreen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _statusText = "";

  void clear_status_timer() {
    Timer timer = new Timer(new Duration(seconds: 3),
      () => setState(() => _statusText = "")
    );
  }

  void validate_user(String email, String password) async {
    if (email == "" || password == "") {
      setState(() => _statusText = "All Fields Are Required");
      clear_status_timer();
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() => _statusText = "No user found for that email.");
        clear_status_timer();
        return;
      } else if (e.code == 'wrong-password') {
        setState(() => _statusText = "Wrong password provided for that user.");
        clear_status_timer();
        return;
      } else {
        setState(() => _statusText = "Set valid credentials.");
        clear_status_timer();
        return;
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
                Text("$_statusText", style: TextStyle(color: Colors.red)),
                ElevatedButton(
                  child: Text("Sign In"),
                  onPressed: () => validate_user(_email.text, _password.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
