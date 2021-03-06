import 'package:flutter/material.dart';
import 'package:pjam_quiz_game/screens/game/game_main.dart';
import 'package:pjam_quiz_game/screens/records/record.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100,
                child: Text("Quiz Game OpenTriviaDB\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    )),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Game()),
                  );
                },
                child: Text('Play', textAlign: TextAlign.center),
                shape: StadiumBorder(),
                color: Colors.green,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Record()),
                  );
                },
                child: Text('Records', textAlign: TextAlign.center),
                shape: StadiumBorder(),
                color: Colors.orange[700],
                textColor: Colors.white,
              ),
            ]));
  }
}
