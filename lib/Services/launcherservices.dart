import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter/material.dart';

launchURL(String inputController) async {
  var url = inputController;
  _launch(url);
}


_launch(url) async {
   if( await canLaunch(url) ){
     await launch(url);
   } else {
     throw 'Could not Launch $url';
   }
}