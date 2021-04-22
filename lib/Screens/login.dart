import 'package:firebaseauth/Screens/urlsearch.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<Login> {

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: Text(
            'Easacc App',
        ),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 360,
              child: TextFormField(
                validator: (input) {
                  if(input.isEmpty) {
                    return 'Please type an email';
                  }
                  return input;
                },
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
                controller: emailTextController,
              ),
            ),
            SizedBox(
              width: 360,
              child: TextFormField(
                obscureText: true,
                validator: (input) {
                  if(input.isEmpty) {
                    return 'Please type an password';
                  }
                  
                  return input;
                },
                decoration: InputDecoration(
                    labelText: 'Password'
                ),

                controller: passwordTextController,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 360,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.mail, size: 30),
                    Text(
                      '  Login with Email',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                textColor: Colors.white,
                color: Colors.yellow[600],
                padding: EdgeInsets.all(10),
                onPressed: () {
                  signUpWithMail();
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 360,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up, size: 30),
                    Text(
                      '  Login with Facebook',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                textColor: Colors.white,
                color: Colors.blue[900],
                padding: EdgeInsets.all(10),
                onPressed: () {
                  signUpWithFacebook();
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 360,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alternate_email, size: 30),
                    Text(
                      '  Login with Google',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                textColor: Colors.white,
                color: Colors.red,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  _googleSignUp();
                },
              ),
            ),
           ],
        ),
      ),
    );
  }

  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UrlSearch()),
            );

      return user;
    }catch (e) {
      print(e.message);
    }
  }

  Future<void> signUpWithFacebook() async{
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {

        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,);

        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        
                   
        return Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UrlSearch()),
            );
      }
     
    }catch (e) {
      print(e.message);
    }
  }

  Future<void> signUpWithMail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text
      );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UrlSearch()),
            );
      
    }catch(e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          }
      );
    }

  }
}
/*showDialog(
          context: context,
        builder: (context) {
            return AlertDialog(
              content: Text('Success sign in'),
            );
        }
      );


      //button for search 
      SizedBox(height: 20),
            SizedBox(
              width: 360,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.vpn_lock, size: 30),
                    Center(
                      child: Text(
                      '  Open Browser',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ],
                ),
                textColor: Colors.white,
                color: Colors.green[600],
                padding: EdgeInsets.all(10),
               onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UrlSearch()),
              );
               }
              ),
            ),

      */