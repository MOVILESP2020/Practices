import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/login/login.dart';
import 'package:practice_one/register/register.dart';

class Navigation extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _NavigationState();
  }

}

class _NavigationState extends State<Navigation> {
  
  _openLogin(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => Login())
    );
  }
  
  _openRegister(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => Register())
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [blue2, blue1]
          )
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 56,
                  horizontal: 16
              ),
              child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/cupping.png')
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  height: 48,
                  color: gray1,
                  child: Text(
                      'REGISTRATE'
                  ),
                  onPressed: () => _openRegister(context),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    height: 48,
                    color: gray1,
                    child: Text(
                        'INGRESA'
                    ),
                    onPressed: () => _openLogin(context),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

}