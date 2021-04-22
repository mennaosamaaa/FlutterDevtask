import 'package:firebaseauth/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media Login',
      color: Colors.blueAccent[100],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>
with SingleTickerProviderStateMixin {
 
   AnimationController controller;
   Animation animation;
     
      @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds : 1),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener((){
       setState(() {} );  
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0 ,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Easacc App'],
                  textStyle: TextStyle(
                    
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
             SizedBox(
              height: 150.0,
            ),
            RaisedButton(
              child: Text(
                '  Login',
                style: TextStyle(fontSize: 28),
              ),
                hoverElevation: 2.0,
                elevation: 10.0,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                textColor: Colors.white,
                color: Colors.blueAccent[100],
                padding: EdgeInsets.all(5.0),
                onPressed: (){
                  Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Login()),
                  );
              }
            ),
            
            
          ],
        ),      ),
    );
  }
}