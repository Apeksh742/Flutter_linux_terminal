import 'package:authentication/email.dart';
import 'package:authentication/signInEmail.dart';
import 'package:authentication/signup.dart';
import 'package:authentication/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';


void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
         'SignUpMethods' : (context) => SignUp(),
         'SignUp' : (context)=> SignUpUsingEmail(), 
         'SignIn' : (context) => SignInEmail(),
         'Home'   : (context) => HomePage(),

      },
      debugShowCheckedModeBanner: false,
      title: 'Meet Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: IntroScreen(),
        );
  }
}