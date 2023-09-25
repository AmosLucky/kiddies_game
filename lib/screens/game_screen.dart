import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kidie_game/repos/game_controller.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var gameJSON = [
    {
      "id": 0,
      "question": "What animal",
      "image": "ani_1.png",
      "options": ["ant", "lion", "monkey"],
      "correct": "zebra"
    },
    {
      "id": 1,
      "question": "What animal",
      "image": "ani_2.png",
      "options": ["Dog", "Zebra", "Ant"],
      "correct": "elephant"
    },
    {
      "id": 2,
      "question": "What animal",
      "image": "ani_3.png",
      "options": ["Elephant", "Wolf", "Fish"],
      "correct": "Cow"
    },
    {
      "id": 3,
      "question": "What animal",
      "image": "ani_4.png",
      "options": ["Cat", "zebra", "Elphant"],
      "correct": "dog"
    },
    {
      "id": 4,
      "question": "What animal",
      "image": "ani_5.png",
      "options": ["Hen", "dog", "lion"],
      "correct": "cat"
    },
  ];
  Map currentQuestion = {};
  GameController? gameController;
  @override
  void initState() {
    gameController = GameController();

    currentQuestion = gameJSON[gameController!.currentLevel];
    // TODO: implement initState
    super.initState();
  }
  List mixOptions(List options,answer){
    var random = Random().nextInt(3);
    options.insert(random, answer);
    return options;

  }

  void checkAnswer(String choice){
    

  }



  showAlert(BuildContext context, String result) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(result),
    content: Text(result),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  @override
  Widget build(BuildContext context) {
     GameController gameController = context.watch<GameController>();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        child: Column(children: [
          Container(
            height: 80,
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.pinkAccent,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                gameJSON[gameController!.currentLevel]['question'].toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.pinkAccent,
            padding: const EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  flex: 1,
                  // ignore: prefer_interpolation_to_compose_strings
                  child: Animate(
                     effects: [FadeEffect(), ScaleEffect(delay:Duration(milliseconds: 100), )],
                    child: Image.asset("assets/images/" +
                        gameJSON[gameController!.currentLevel]['image']
                            .toString()),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    
                   // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: mixOptions(gameJSON[gameController!.currentLevel]['options']
                              as List,gameJSON[gameController!.currentLevel]['correct'])
                          .map((e) {
                            var i = 1;
                            return Animate(
                            effects: [FadeEffect(), ScaleEffect(delay:Duration(milliseconds: 100*1), )],
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              height: 50,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                      child: MaterialButton(
                                        color: Colors.white,
                                        child: Text(e,style:const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                    onPressed: () {
                                     if(e.toLowerCase() == gameJSON[gameController!.currentLevel]['correct'].toString().toLowerCase()){
     
     if(gameController!.currentLevel == (gameJSON.length -1)){
      ////won
     showAlert(context,"Won");
     }else{
      ///Continue
      //  setState(() {
        
      // });
      var newRoute =  MaterialPageRoute(builder: (BuildContext)=>GameScreen());
      Navigator.of(context).pushReplacement(newRoute);
       gameController!.saveCurrentLevel((gameController!.currentLevel+1));
       currentQuestion = gameJSON[gameController!.currentLevel];

     }

    }else{
      ///failed
      showAlert(context,"incorrect");

    }
                                    },
                                  )),
                                ),
                          );
  }
                          )
                          .toList(),
                    ),
                  ))
            ]),
          )
        ]),
      )),
    );
  }
}
