import 'package:flutter/material.dart';
import 'package:pjam_quiz_game/screens/game/game_main.dart';

class Victory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Victory!'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150,
                child: Text("Congratulations, you won with 10 corrects answers",
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
