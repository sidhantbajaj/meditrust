import 'package:flutter/material.dart';

class Dialogbox extends StatelessWidget {

  Dialogbox({this.test});
  final String test;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Your $test test has been added'),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black
      ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        )
    );
  }
}
