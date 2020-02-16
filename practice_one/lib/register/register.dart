import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/home/home.dart';
import 'package:practice_one/login/login.dart';
import 'package:practice_one/utils/constants.dart';

class Register extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {

  var _obscure = true;
  var _terms = true;

  _openHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => Home(title: APP_TITLE)),
            (Route<dynamic> route) => false
    );
  }
    _openLogin(BuildContext context) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
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
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              labelStyle: TextStyle(color: blue1),
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
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
                              labelText: 'Correo',
                              labelStyle: TextStyle(color: blue1),
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
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
                                  _obscure ? Icons.visibility : Icons
                                      .visibility_off,
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Checkbox(
                              value: _terms,
                              onChanged: (b) {
                                setState(() {
                                  _terms = b;
                                });
                              },
                              activeColor: gray1,
                            ),
                            Text('ACEPTO LOS TERMINES Y CONDICIONES',
                              style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Padding(
                            padding: EdgeInsets.all(
                                16
                            ),
                            child: MaterialButton(
                              height: 48,
                              color: gray1,
                              child: Text('REGISTRATE'),
                              onPressed: () => _openHome(context),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('¿Ya tienes cuenta?',
                                  style: TextStyle(color: Colors.white),),
                                GestureDetector(
                                  onTap: (){
                                    _openLogin(context);
                                  },
                                  child: Text('INGRESA',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}