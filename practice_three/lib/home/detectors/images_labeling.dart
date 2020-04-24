import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:practica_tres/bloc/application_bloc.dart';

import '../details.dart';

class ImagesLabeling extends StatefulWidget {
  ImagesLabeling({Key key}) : super(key: key);

  @override
  _ImagesLabelingState createState() => _ImagesLabelingState();
}

class _ImagesLabelingState extends State<ImagesLabeling> {
  
  ApplicationBloc _appBloc;

  @override
  void initState() {
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
    return BlocListener<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
      if (state is ErrorState) {
          // snackbar
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("${state.message}"),
                duration: Duration(seconds: 1),
              ),
            );
        }        
      },
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          print(state);
          if (state is LoadingState) {
            print('Images Labeling Loading State');
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTileShimmer();
              }
            );            
          }          
          print("Labels: " + _appBloc.getLabeledItemsList.toString());
          int _listSize = _appBloc.getLabeledItemsList.length;
          return _listSize > 0 
              ? ListView.builder(
                  itemCount: _listSize,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.code),
                              backgroundColor: Colors.amber[50],
                            ),
                            title: Text(
                              "$index - Codigo ${_appBloc.getLabeledItemsList[index].identificador}",
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return Details(
                                      imageLabeled:
                                          _appBloc.getLabeledItemsList[index],
                                    );
                                  },
                                ),
                              );
                            },
                          );
                  },
                )
              : Center(child: Text("Todavia no hay objetos escaneados"));
        },
      ),
    );
  }
}
