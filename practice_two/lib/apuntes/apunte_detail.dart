import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:practica_dos/models/apunte.dart';

class ApunteDetail extends StatefulWidget {
  final Apunte apunte;

  ApunteDetail({Key key, @required this.apunte}) : super(key: key);

  @override
  _ApunteDetailState createState() => _ApunteDetailState();
}

class _ApunteDetailState extends State<ApunteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SingleChildScrollView(
           child: Column(
           children: <Widget>[
             Container(
              width: MediaQuery.of(context).size.width - 16,
              height: MediaQuery.of(context).size.height*0.60 - 16,
              child: PhotoView(
                  imageProvider: NetworkImage(widget.apunte.imageUrl),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.white
                  ),
              ),
             ),
             Padding(
               padding: EdgeInsets.only(left: 8, right: 8, top: 8),
               child: Text(
                 widget.apunte.materia,
                 style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                 ),
                 ), 
              ), 
             Padding(
               padding: EdgeInsets.only(left: 8, right: 8, top: 8),
               child: Text(
                 widget.apunte.descripcion,
                 style: TextStyle(
                    fontSize: 14
                 ),
                 ), 
              ), 

           ],
         ),
        )
       );
  }
}