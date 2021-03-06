import 'package:flutter/material.dart';
import 'package:pjam_quiz_game/screens/game/game_main.dart';

class Defeat extends StatelessWidget {
  final String question;
  final String correctAnswer;
  Defeat({Key key, @required this.correctAnswer, @required this.question})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Defeat!'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 75,
                child: Text(question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ),
              Container(
                height: 75,
                child: Text("The correct answer was: " + correctAnswer,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Game()),
                  );
                },
                child: Text('Play Again', textAlign: TextAlign.center),
                shape: StadiumBorder(),
                color: Colors.green,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text('Menu', textAlign: TextAlign.center),
                shape: StadiumBorder(),
                color: Colors.red,
                textColor: Colors.white,
              ),
            ]));
  }
}
