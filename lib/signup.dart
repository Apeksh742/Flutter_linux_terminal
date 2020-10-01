import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Meet Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Email,
                  text: "Sign up with Email",
                  onPressed: () {
                    Navigator.pushNamed(context, 'SignUp');
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {},
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Twitter,
                  text: "Sign up with Twitter",
                  onPressed: () {},
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: Text("Log In Using Email",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                            onTap: () {
                               Navigator.pushNamed(context, 'SignIn');
                                   }
                                 )
                                )
                              ]
                            ),
                        )
                     ) ;
  }
}