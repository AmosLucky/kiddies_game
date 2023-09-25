import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidie_game/repos/game_controller.dart';
import 'package:kidie_game/screens/game_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // ignore: non_constant_identifier_names
  @override
  void initState() {

    Timer(Duration(seconds: 3), () {
      GameController().saveCurrentLevel(0);
      var route = MaterialPageRoute(builder: (BuildContext)=>GameScreen());
      Navigator.push(context, route);
     
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child:const Center(child:  Text("Kiddies Game", style: TextStyle(color: Colors.orange,fontSize: 40,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}