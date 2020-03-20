import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/apunte_detail.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';
import 'package:practica_dos/models/apunte.dart';

class ItemApuntes extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  final int index;
  ItemApuntes({
    Key key,
    @required this.imageUrl,
    @required this.index,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _ItemApuntesState createState() => _ItemApuntesState();
}

class _ItemApuntesState extends State<ItemApuntes> {

  void _openApunteDetail(Apunte a) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ApunteDetail(apunte: a,))
    );
  }

void _deleteItem() {
  BlocProvider.of<ApuntesBloc>(context).add(
    RemoveDataEvent(index: widget.index),
  );
}

 void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Eliminar"),
          content: new Text("Está seguro que sea eliminar el elemento."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                _deleteItem();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Apunte ap = Apunte(materia: widget.materia, descripcion: widget.descripcion, imageUrl: widget.imageUrl);
        print("tap: $ap");
        _openApunteDetail(ap);
      },
      child: Card(
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showDialog();
                },
              )
            ],
          ),
          Image.network(
            widget.imageUrl ?? "https://via.placeholder.com/150",
            height: 150,
            width: 150,
            fit: BoxFit.scaleDown,
          ),
          Container(
            child: Text(
              "${widget.materia}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text("${widget.descripcion}"),
          ),
          SizedBox(height: 12),
        ],
      ),
     ),
    );
  }
}
