import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'MainScreen.dart';

class MainEmailAuthScreen extends StatelessWidget {
  MainEmailAuthScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Email Auth"),
        backgroundColor: Colors.grey[900],
      ),
      body: new Container(
        color: Colors.grey[900],
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 200,
                child: new ElevatedButton(
                  child: new Row(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.key),
                        onPressed: () => {},
                      ),
                      new Text("Sign in"),
                    ]
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new SigninScreen(),
                      ),
                    )
                  },
                  style: new ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                ),
              ),

              new Text(""),

              new Container(
                width: 200,
                child: new ElevatedButton(
                  child: new Row(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.person_add),
                        onPressed: () => {},
                      ),
                      new Text("Sign up"),
                    ]
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new SigninScreen(),
                      ),
                    )
                  },
                  style: new ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  UserCredential? userCredential;
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
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

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
      MaterialPageRoute(builder: (context) => MainScreen(uid: userCredential?.user?.uid)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: new Center(
        child: new Container(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _email,
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey,),
                        ),
                        labelText: "Email",
                        labelStyle: new TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      controller: _password,
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey,),
                        ),
                        labelText: "Password",
                        labelStyle: new TextStyle(color: Colors.grey),
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
        ),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  UserCredential? userCredential;
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
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

    } on FirebaseAuthException catch (e) {
      print("Error ocurred");
      print(e);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(uid: userCredential?.user?.uid)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: new Center(
        child: new Container(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _password,
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey,),
                        ),
                        labelText: "Email",
                        labelStyle: new TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      controller: _password,
                      decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey,),
                        ),
                        labelText: "Password",
                        labelStyle: new TextStyle(color: Colors.grey),
                      ),
                    ),
                    Text("$_statusText", style: TextStyle(color: Colors.red)),
                    ElevatedButton(
                      child: Text("Sign Up"),
                      onPressed: () => validate_user(_email.text, _password.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
