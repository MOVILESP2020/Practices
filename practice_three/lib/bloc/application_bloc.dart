import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica_tres/models/barcode_item.dart';
import 'package:practica_tres/models/image_label_item.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  List<ImageLabelItem> _listLabeledItems = List();
  List<BarcodeItem> _listBarcodeItems = List();

  List<ImageLabelItem> get getLabeledItemsList => _listLabeledItems;
  List<BarcodeItem> get getBarcodeItemsList => _listBarcodeItems;

  File _picture;

  @override
  ApplicationState get initialState => ApplicationInitial();

  @override
  Stream<ApplicationState> mapEventToState(
    ApplicationEvent event,
  ) async* {
    // Simula estar cargando datos remotos o locales
    if (event is FakeFetchDataEvent) {
      yield LoadingState();
      await Future.delayed(Duration(milliseconds: 1500));
      yield FakeDataFetchedState();
    }
    // pasar imagen a ui para pintarla
    else if (event is TakePictureEvent) {
      await _takePicture();
      if (_picture != null) {
        yield PictureChosenState(image: _picture);
      } else {
        yield ErrorState(message: "No se ha seleccionado imagen");
      }
    }
    // detectar objetos en imagenes
    else if (event is ImageDetectorEvent) {
      yield LoadingState();
      await _imgLabeling(_picture);
      yield FakeDataFetchedState();
    }
    // detectar barcoes y qr en imagenes
    else if (event is BarcodeDetectorEvent) {
      yield LoadingState();
      await _barcodeScan(_picture);
      yield FakeDataFetchedState();
    }
  }

  Future<void> _takePicture() async {
    _picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 320,
      maxWidth: 320,
    );
  }

  Future<void> _imgLabeling(File imageFile) async {
    // TODO
  }

  Future<void> _barcodeScan(File imageFile) async {
    // TODO
  }
}
