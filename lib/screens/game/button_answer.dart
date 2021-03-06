import 'package:flutter/material.dart';

class ButtonAnswer extends StatefulWidget {
  final bool isCorrect;
  final String text;

  const ButtonAnswer({Key key, this.text, this.isCorrect}) : super(key: key);

  @override
  _ButtonAnswerState createState() => _ButtonAnswerState();
}

class _ButtonAnswerState extends State<ButtonAnswer> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Text(widget.text, textAlign: TextAlign.center),
      shape: StadiumBorder(),
      color: Colors.blue[700],
      textColor: Colors.white,
    );
  }
}
