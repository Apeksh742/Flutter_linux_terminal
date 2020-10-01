import 'package:authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'HomePage.dart';

class IntroScreen extends StatefulWidget{

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  final FirebaseAuth auth =  FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   
    return StreamBuilder<User>(
      stream: auth.authStateChanges() ,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignUp();
          }
          print("homePge");
          return HomePage();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          print("Waiting");
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return null;
      },
    );
  }
}