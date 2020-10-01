import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TextEditingController command = TextEditingController();
  var input;
  @override
  void initState(){
    super.initState();
    firestoreInstance.collection("Users").doc(firebaseUser.uid).set(
    {
      "Result": "",
      "statusCode":"",
    }
  );
  }

  getOutput(input) async {
    var url = 'http://13.235.23.107/cgi-bin/cmd.py?x=$input';
    var result = await http.get(url);
    // print(result.body);
    // print(result.body.runtimeType);
    var output = json.decode(result.body);
    // print(output);
    
    await firestoreInstance.collection("Users").doc(firebaseUser.uid).set(
      {
        "Result": output['Result'],
        "statusCode": output['statusCode'] 
      }
      
    ).then((_) => print("Sucess"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form( key: _formKey,
                child:Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,15,8,8),
                      child: Center(child: Text("Terminal",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: command,
                        decoration: InputDecoration(
                          labelText: "Enter command",
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                             borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Do not leave blank';
                          }
                          input = value;
                          return null;
                        },
                      ),
                    ),
                    Center(child: FloatingActionButton.extended(onPressed: (){
                      if(_formKey.currentState.validate()){
                        getOutput(input);
                      }
                    }, label: Text("Run"), backgroundColor: Colors.green, icon: Icon(Icons.fast_forward),))
                  ],
                ),
                ),
              SizedBox(height: 30,),
              StreamBuilder(
                stream: firestoreInstance.collection("Users").doc(firebaseUser.uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (!snapshot.hasData)
                    return  Text("No Data");
                  else {
                    var info = snapshot.data.data();
                    // print(info['ContainerID']);
                    return SingleChildScrollView(
                      child: Container(
                        width:  (MediaQuery.of(context).size.width)*0.95,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text( (info['Result'] != null) ? info['Result'] : "" ,style: TextStyle( color: Colors.white),),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.yellow, style: BorderStyle.solid)
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),                
        ),
      ),
    );
  }
}