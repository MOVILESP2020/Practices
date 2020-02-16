import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/home/home.dart';
import 'package:practice_one/register/register.dart';
import 'package:practice_one/utils/constants.dart';

class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  var _obscure = true;

  _openHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Home(title: APP_TITLE)),
            (Route<dynamic> route) => false
    );
  }
  _openRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => Register()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              Expanded(
                flex: 1,
                child: Container(
                    child: Image.asset(
                      'assets/cupping.png',
                      width: 200,
                      height: 200,
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    filled: true,
                      labelStyle: TextStyle(color: blue1),
                      fillColor: Colors.white,
                    border: InputBorder.none
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16
                ),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: blue1),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                        color: gray1,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscure,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child:  Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: MaterialButton(
                    height: 48,
                    color: gray1,
                    child: Text('ENTRAR'),
                    onPressed: ()=>_openHome(context),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16,
                        ),
                        child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.white),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 16
                        ),
                        child: Column(
                          children: <Widget>[
                            Text('¿Aún no tienes cuenta?', style: TextStyle(color: Colors.white),),
                            GestureDetector(
                              onTap:() {
                                _openRegister(context);
                              },
                              child: Text('REGISTRATE', style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      )
    );
  }
}