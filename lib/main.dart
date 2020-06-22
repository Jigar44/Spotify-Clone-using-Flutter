import 'package:flutter/material.dart';
import 'package:spotify_clone/components/auth.dart';

void main(){
  runApp(MaterialApp(
    title: 'Spotify Clone',
    theme: ThemeData(
      fontFamily: 'Proxima Nova',
      brightness: Brightness.dark,
      primaryColor: Colors.green[900],
      accentColor: Colors.lightGreen[800],
    ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}