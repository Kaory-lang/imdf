import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './EmailAuthenticationScreen.dart';
import './MainScreen.dart';

class SelectAuthMethodScreen extends StatefulWidget {
  SelectAuthMethodScreen({ super.key });

  @override
  _SelectAuthMethodScreenState createState() => _SelectAuthMethodScreenState();
}

class _SelectAuthMethodScreenState extends State<SelectAuthMethodScreen> {
  Widget create_auth_btn(String label, Widget pageRoute, Icon icon, Color color) {
    return new Container(
      width: 200,
      child: new ElevatedButton(
        child: new Row(
          children: <Widget> [
            new IconButton(
              icon: icon,
              onPressed: () => {},
            ),
            new Text("${label}"),
          ],
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pageRoute,
            ),
          ),
        },
        style: new ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Auth Screen"),
        backgroundColor: Colors.grey[900],
      ),
      body: new Container(
        color: Colors.grey[900],
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              create_auth_btn("Email Auth", new MainEmailAuthScreen(), new Icon(Icons.email), Colors.grey),
              new Text(""),
              create_auth_btn("Google Auth", new GoogleAuthentication(), new Icon(Icons.email), Colors.red.shade600),
              new Text(""),
              create_auth_btn("Facebook Auth", new FacebookAuthentication(), new Icon(Icons.facebook), Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleAuthentication extends StatelessWidget {
  GoogleAuthentication({ super.key });

  Future<UserCredential> sign_in_with_google() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> userData = this.sign_in_with_google();
    userData.then((userCredential) => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(uid: userCredential?.user?.uid)),
      ),
    });

    return new Text("SIGNIN IN WITH GOOGLE");
  }
}

class FacebookAuthentication extends StatelessWidget {
  FacebookAuthentication({ super.key });

  Future<UserCredential> sign_in_with_facebook() async {
    // Create a new provider
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();

    facebookProvider.addScope('email');
    facebookProvider.setCustomParameters({
      'display': 'popup',
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(facebookProvider);

  }

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> userData = this.sign_in_with_facebook();
    userData.then((userCredential) => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(uid: userCredential?.user?.uid)),
      ),
    });

    return new Text("SIGNIN IN WITH FACEBOOK");
  }
}
