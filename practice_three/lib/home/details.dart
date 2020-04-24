import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica_tres/models/barcode_item.dart';
import 'package:practica_tres/models/image_label_item.dart';

class Details extends StatefulWidget {
  final BarcodeItem barcode;
  final ImageLabelItem imageLabeled;
  Details({
    Key key,
    this.barcode,
    this.imageLabeled,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    // convierte la string base 64 a bytes para poder pintar Image.memory(Uint8List)
    Widget detail;
    if (widget.barcode != null) {
      imageBytes = base64Decode(widget.barcode.imagenBase64);
      print(widget.barcode);
      detail = _generateBarcodeDetail(widget.barcode);
    } else {
      imageBytes = base64Decode(widget.imageLabeled.imagenBase64);
      print(widget.imageLabeled);
      detail = _generateLabelDetail(widget.imageLabeled);
    }
    
    return Scaffold(
      appBar: AppBar(title: Text("Detalles")),
      body: detail,
    );
  }

  Widget _generateLabelDetail(ImageLabelItem item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Image.memory(base64Decode(item.imagenBase64), width: 300, height: 300,fit: BoxFit.contain,), 
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('Identificador', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('${item.identificador}', style: TextStyle(fontSize: 16),),
            ),                      
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('Texto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('${item.texto}', style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('Similitud', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('${item.similitud}', style: TextStyle(fontSize: 16),),
            ),  
          ],
        ),        
      ],
    );
  }

    Widget _generateBarcodeDetail(BarcodeItem item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: CustomPaint(
              foregroundPainter: RectPainter(pointsList: item.puntosEsquinas),
              child: Image.memory(base64Decode(item.imagenBase64),),
            ), 
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('${item.tipoCodigo}', style: TextStyle(fontSize: 16),),
            ),                      
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('Título URL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('${item.tituloUrl}', style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('URL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Text('${item.url.url}', style: TextStyle(fontSize: 16),),
            ),  
          ],
        ),
      ],
    );
  }

}

class RectPainter extends CustomPainter {
  final List<Offset> pointsList;

  RectPainter({@required this.pointsList});

  @override
  bool shouldRepaint(CustomPainter old) => false;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(pointsList[0], pointsList[2]);
    final line = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRect(rect, line);
  }
}
