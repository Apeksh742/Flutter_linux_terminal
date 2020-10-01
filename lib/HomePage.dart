import 'package:authentication/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text("Welcome"), backgroundColor: Colors.black,
          ),
          drawer:Drawer(  
            child: ListView(  
          // Important: Remove any padding from the ListView.  
          padding: EdgeInsets.zero,  
          children: <Widget>[  
            UserAccountsDrawerHeader(  
              accountName: Text("Apeksh Agarwal"),  
              accountEmail: Text("apeksh8@gmail.com"),  
              currentAccountPicture: CircleAvatar(  
                backgroundColor: Colors.red,  
                child: Text(  
                  "A",  
                  style: TextStyle(fontSize: 40.0),  
                ),  
              ),  
            ),  
            ListTile(  
              leading: Icon(Icons.home), title: Text("Home"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: Icon(Icons.settings), title: Text("Settings"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: Icon(Icons.contacts), title: Text("Contact Us"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: Icon(Icons.exit_to_app), title: Text("Log Out"),  
              onTap: () {  
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Text("Log out of app?"),
                    content: Text("Are you sure you want to log out of the app!"),
                    actions: <Widget>[
                       FlatButton(onPressed: (){
                         Navigator.of(context).pop();},
                         child: Text("Cancel")),
                       FlatButton(onPressed: () async {
                         await FirebaseAuth.instance.signOut();
                         Navigator.pushNamedAndRemoveUntil(context, 'SignUpMethods', (route) => false);},
                         child: Text("Log Out"))
                    ],
                  );
                });
              },  
            ),
          ],  
        ),  
      ),
          body: Body()
    );
  }
}