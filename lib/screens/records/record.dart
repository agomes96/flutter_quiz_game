import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Record extends StatefulWidget {
  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  int _lifetimeAnswers;
  int _consecutiveAnswers;
  int _currentConsecutiveAnswers;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lifetimeAnswers = prefs.getInt("lifetimeAnswers");
      _consecutiveAnswers = prefs.getInt("consecutiveAnswers");
      _currentConsecutiveAnswers = prefs.getInt("currentConsecutiveAnswers");
    });

    if (_lifetimeAnswers == null) {
      await prefs.setInt('lifetimeAnswers', 0);
      setState(() {
        _lifetimeAnswers = 0;
      });
    }
    if (_consecutiveAnswers == null) {
      await prefs.setInt('consecutiveAnswers', 0);
      setState(() {
        _consecutiveAnswers = 0;
      });
    }
    if (_currentConsecutiveAnswers == null) {
      await prefs.setInt('currentConsecutiveAnswers', 0);
      setState(() {
        _currentConsecutiveAnswers = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Records'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 75,
                child: Text(
                    "Current Correct Consecutive Answers: " +
                        _currentConsecutiveAnswers.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ),
              Container(
                height: 75,
                child: Text(
                    "Lifetime Correct Consecutive Answers: " +
                        _consecutiveAnswers.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ),
              Container(
                height: 75,
                child: Text(
                    "Lifetime Correct Answers: " + _lifetimeAnswers.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
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
