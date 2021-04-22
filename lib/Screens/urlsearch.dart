
import'package:flutter/material.dart';
import '../main.dart';
import '../Services/launcherservices.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'dart:async';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:firebaseauth/Screens/webview.dart';

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class UrlSearch extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  UrlSearchPage(),
    );
  }
}

class UrlSearchPage extends StatefulWidget {
  UrlSearchPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UrlSearchPageState createState() => _UrlSearchPageState();
}

class _UrlSearchPageState extends State<UrlSearchPage> {

   TextEditingController myController = new TextEditingController();
   
   void dispose() {
     myController.dispose();
     super.dispose();
   }
  
  
 Item selectedUser;
  List<Item> users = <Item>[
    const Item('WiFi',Icon(Icons.wifi,color:  const Color(0xFF167F67),)),
    const Item('Bluetooth',Icon(Icons.bluetooth,color:  const Color(0xFF167F67),)),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        actions: <Widget>[
            IconButton(
              icon: Icon(
               Icons.close,
               color: Colors.white,
              ),
             onPressed: () {
              Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => MyHomePage())
              );
             },
            )
        ],
        title: Text('Easacc App',),
      ),
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:<Widget>[ Center(
          child: Container(
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             color: Colors.blueAccent[100],
            ),
          
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
               children: <Widget>[
                 Expanded(
                   flex: 6,
                  child:  TextField(
                         controller: myController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search', 
                          border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                        ), 
                        onSubmitted: (myController){
                          setState(() {
                            launchURL(myController);
                          });
                        },  
                      ),
                  ),
                  Expanded(
                    child:  IconButton(icon: Icon(Icons.cancel), 
                       onPressed: (){
                         setState(() {
                          myController.clear();
                         });
                        },
                      ),
                  ),
        ],
       ),
      ),
    ),
  ),
  DropdownButton<Item>(
     hint:  Text("Settings"),
     value: selectedUser,
     onChanged: (Item Value) {
         setState(() {
           selectedUser = Value;
         });
      },
          items: users.map((Item user) {
              return  DropdownMenuItem<Item>(
                value: user,
                child: Row(
                  children: <Widget>[
                    user.icon,
                    SizedBox(width: 10,),
                    Text(
                      user.name,
                      style:  TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
       ]
     ),
  );
 }
 }

