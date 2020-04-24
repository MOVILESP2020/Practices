import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_tres/bloc/application_bloc.dart';
import 'package:practica_tres/utils/constants.dart';

class NewPicture extends StatefulWidget {
  final int type;
  NewPicture({@required this.type, Key key}) : super(key: key);

  @override
  _NewPictureState createState() => _NewPictureState();
}

class _NewPictureState extends State<NewPicture> {

  String _analize;
  ApplicationBloc _appBloc;

  @override
  void initState() {
    if (widget.type == BARCODE) {
      _analize = "barcode";
    } else {
      _analize = "image labeling";
    }
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    // _appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar imagen")),
      body: BlocListener<ApplicationBloc, ApplicationState>(
        listener: (context, state) {
          if (state is ErrorState) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("${state.message}"),
                  duration: Duration(milliseconds: 600),
                ),
              );
          }
        },
        child: BlocBuilder<ApplicationBloc, ApplicationState>(
          builder: (context, state) {
            if (state is PictureChosenState) {
              return Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 24),
                    Image.file(
                      state.image,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 24),
                    RaisedButton(
                      child: Text("Analizar " + _analize),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (widget.type == BARCODE) {
                          BlocProvider.of<ApplicationBloc>(context).add(BarcodeDetectorEvent());
                        } else {
                          BlocProvider.of<ApplicationBloc>(context).add(ImageDetectorEvent());
                        }
                        
                      },
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text("Agrega una imagen"),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        tooltip: "Agregar imagen",
        child: Icon(Icons.add_photo_alternate),
        onPressed: () {
          print('Take picture');
          _appBloc.add(TakePictureEvent());
        },
      ),
    );
  }
}
