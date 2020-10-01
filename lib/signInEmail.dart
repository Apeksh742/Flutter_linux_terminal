import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInEmail extends StatefulWidget {
  @override
  _SignInEmailState createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
 
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isUserCorrect = false;

  loginUser({String email, String password}) async {
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password,
        );
       Navigator.pushNamedAndRemoveUntil(context, 'Home', (route) => false);
    } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    _showDialog('No User found');
    setState(() {
      isLoading = false;
    });

  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    _showDialog('Wrong password provided');
    setState(() {
      isLoading = false;
    });
    }
   }
   catch (e){
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
          progressIndicator: CircularProgressIndicator(), 
          child: Scaffold(
            appBar: AppBar(title: Text("Log In"),backgroundColor: Colors.black,),
            body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Log In",style: TextStyle(
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
                   loginUser(email: emailController.text, password: passwordController.text);
                 }
                 setState(() {
                   isLoading = true;
                 });
                 Future.delayed(const Duration(seconds: 10),(){
                   if (mounted) {
                     setState(() {
                       isLoading = false;
                     });
                   }
                 });
                },
                child: Text('Log In'),
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