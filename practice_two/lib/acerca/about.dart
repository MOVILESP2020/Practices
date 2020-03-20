import 'package:flutter/material.dart';
import 'package:practica_dos/contact/contact.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  void _openContact(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Contact())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Text(
                    'Aplicación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Text(
                    'La aplicación nos permite agregar recordatorios y notas.',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Text(
                    'Versión',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Text(
                    '1.0',
                    style: TextStyle(
                      fontSize: 16
                    ),                    
                  ),
                ),  
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Text(
                    'Desarrollador',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),                    
                  ),
                ),    
                Padding(
                  padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Text(
                    'Isaac Cabrera Cortés',
                    style: TextStyle(
                      fontSize: 16
                    ),                    
                  ),
                ),                                
              ],
            )
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                      print("contact developer");
                      _openContact(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Contacta al desarrollador',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        ),
                        textAlign: TextAlign.center,
                      ),            
                    )
                  ),
                )
              ],
            )
          ),
        ],
      )
    );
  }
}
