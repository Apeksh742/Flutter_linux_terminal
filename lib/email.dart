import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpUsingEmail extends StatefulWidget {
  @override
  _SignUpUsingEmailState createState() => _SignUpUsingEmailState();
}

class _SignUpUsingEmailState extends State<SignUpUsingEmail> {

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  registerUser({String email, String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
     );
     Navigator.pushNamedAndRemoveUntil(context, 'Home', (route) => false);
  } 
  on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    _showDialog('Weak Password');
    setState(() {
      isLoading = false;
    });
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    _showDialog('Account already exist');
    setState(() {
      isLoading = false;
    });
  }
} catch (e) {
  print(e.toString());
}
  }

  void _showDialog(String errorInfo){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Error"),
        content: Text(errorInfo),
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.of(context).pop();},
           child: Text("Close"))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(title: Text("Sign Up"),backgroundColor: Colors.black),
            body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Sign Up",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Email id",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Email id';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(
               color: Colors.lightBlue,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                   registerUser(email: emailController.text, password: passwordController.text);
                 }
                 setState(() {
                   isLoading = true;
                 });
                 Future.delayed(const Duration(seconds: 5), (){
                   if (mounted) {
                     setState(() {
                       isLoading = false;
                     });
                   }
                 });
               },
                child: Text('Sign Up'),
                ),
               ]
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}