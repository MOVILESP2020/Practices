import 'dart:async';
import 'package:flutter/material.dart';
import 'package:practice_one/navigation/navigation.dart';

class Splash extends StatelessWidget {

  _openHomePage(context) {
    Timer(
        Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Navigation())
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    _openHomePage(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/grains.jpg'),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width - 50,
              child: Image.asset('assets/cupping.png'),
            ),
          )
        ],
      )
    );
  }
  
}