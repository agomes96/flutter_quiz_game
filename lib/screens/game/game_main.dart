import 'package:flutter/material.dart';
import 'package:pjam_quiz_game/classes/Question.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pjam_quiz_game/screens/endgame/defeat.dart';
import 'package:pjam_quiz_game/screens/endgame/victory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

Future<Question> fetchQuestions() async {
  final response =
      await http.get('https://opentdb.com/api.php?amount=10&type=multiple');

  if (response.statusCode == 200) {
    return Question.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Future<Question> futureQuestions;
  int _questionNumber = 0;
  int _randomNumber;

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestions();
    randomizer();
  }

  _incrementRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lifetimeAnswer = (prefs.getInt('lifetimeAnswers') ?? 0) + 1;
    await prefs.setInt('lifetimeAnswers', lifetimeAnswer);

    int currentCorrectAnswer =
        (prefs.getInt('currentConsecutiveAnswers') ?? 0) + 1;
    await prefs.setInt('currentConsecutiveAnswers', currentCorrectAnswer);

    int lifetimeCorrectAnswer = (prefs.getInt('consecutiveAnswers') ?? 0);

    if (currentCorrectAnswer > lifetimeCorrectAnswer) {
      await prefs.setInt('consecutiveAnswers', currentCorrectAnswer);
    }
  }

  _resetRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentConsecutiveAnswers', 0);
  }

  ///Function to pick a random number between 0 and 3 to use to order the answers buttons
  void randomizer() {
    Random random = new Random();
    _randomNumber = random.nextInt(4);
  }

  ///Function to check if the user answer is correct
  void checkButton(bool isCorrect, String correctAnswer, String question) {
    if (isCorrect && _questionNumber != 9) {
      randomizer();
      setState(() {});
      _incrementRecord();
      setState(() {
        _questionNumber++;
      });
    } else if (isCorrect && _questionNumber == 9) {
      _incrementRecord();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Victory()),
      );
    } else {
      _resetRecord();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Defeat(
                  question: question,
                  correctAnswer: correctAnswer,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Uncomment to see the number of the correct answer in tittle
          //title:
          //    Text("Quiz Game OpenTriviaDB " + (_randomNumber + 1).toString()),
          title: Text("Quiz Game OpenTriviaDB"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder<Question>(
                future: futureQuestions,
                builder: (context, snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Container(
                        height: 75,
                        child: Text(
                            "${snapshot.data.results[_questionNumber].category}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                      ),
                      Container(
                        height: 150,
                        child: Text(
                            "${snapshot.data.results[_questionNumber].question}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                            )),
                      ),
                      Container(
                        height: 20,
                        child: Text(
                            "Question " +
                                (_questionNumber + 1).toString() +
                                " of 10  ",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            )),
                      ),
                      _randomNumber == 0
                          ? FlatButton(
                              onPressed: () => {checkButton(true, "", "")},
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].correctAnswer}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            )
                          : FlatButton(
                              onPressed: () => {
                                checkButton(
                                    false,
                                    "${snapshot.data.results[_questionNumber].correctAnswer}",
                                    "${snapshot.data.results[_questionNumber].question}")
                              },
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].incorrectAnswers[0]}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            ),
                      _randomNumber == 1
                          ? FlatButton(
                              onPressed: () => {checkButton(true, "", "")},
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].correctAnswer}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            )
                          : FlatButton(
                              onPressed: () => {
                                checkButton(
                                    false,
                                    "${snapshot.data.results[_questionNumber].correctAnswer}",
                                    "${snapshot.data.results[_questionNumber].question}")
                              },
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].incorrectAnswers[1]}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            ),
                      _randomNumber == 2
                          ? FlatButton(
                              onPressed: () => {checkButton(true, "", "")},
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].correctAnswer}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            )
                          : FlatButton(
                              onPressed: () => {
                                checkButton(
                                    false,
                                    "${snapshot.data.results[_questionNumber].correctAnswer}",
                                    "${snapshot.data.results[_questionNumber].question}")
                              },
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].incorrectAnswers[2]}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            ),
                      _randomNumber == 3
                          ? FlatButton(
                              onPressed: () => {checkButton(true, "", "")},
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].correctAnswer}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            )
                          : FlatButton(
                              onPressed: () => {
                                checkButton(
                                    false,
                                    "${snapshot.data.results[_questionNumber].correctAnswer}",
                                    "${snapshot.data.results[_questionNumber].question}")
                              },
                              child: Text(
                                  "${snapshot.data.results[_questionNumber].incorrectAnswers[_randomNumber]}",
                                  textAlign: TextAlign.center),
                              shape: StadiumBorder(),
                              color: Colors.blue[700],
                              textColor: Colors.white,
                            ),
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      Container(
                        height: 150,
                        child: Text("${snapshot.error}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                      )
                    ];
                  } else {
                    ///return container empty while fetch the DB
                    return Container();
                  }
                  // By default
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children);
                },
              ),
            ]));
  }
}
