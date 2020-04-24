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
      print('Bloc Take Picture');
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
      await Future.delayed(Duration(milliseconds: 1000));
      if (await _imgLabeling(_picture)) yield ErrorState(message: 'No labels detected');
      else yield FakeDataFetchedState();
    }
    // detectar barcoes y qr en imagenes
    else if (event is BarcodeDetectorEvent) {
      yield LoadingState();
      await Future.delayed(Duration(milliseconds: 1000));
      if (await _barcodeScan(_picture)) yield ErrorState(message: 'No barcodes detected');
      else yield FakeDataFetchedState();
    }
  }

  Future<void> _takePicture() async {
    _picture = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 320,
      maxWidth: 320,
      imageQuality: 100
    );
  }

  Future<bool> _imgLabeling(File imageFile) async {
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    List<ImageLabel> labels = await labeler.processImage(visionImage);
    for (ImageLabel label in labels) {
      var bytes = imageFile.readAsBytesSync();
      String img64 = base64Encode(bytes);
      _listLabeledItems.add(
        new ImageLabelItem(
          imagenBase64: img64, 
          similitud: label.confidence, 
          identificador: label.entityId, 
          texto: label.text
        )
      );
    }
    return labels.isEmpty;
  }

  Future<bool> _barcodeScan(File imageFile) async {
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List<Barcode> barcodes = await barcodeDetector.detectInImage(visionImage);
    var bytes = imageFile.readAsBytesSync();
    String img64 = base64Encode(bytes);
    print('Barcodes length bloc: ' + barcodes.length.toString());
    for (Barcode barcode in barcodes) {
      String raw = barcode.rawValue ?? '';
      String type = barcode.valueType  == null ? '' : barcode.valueType.toString();
      BarcodeURLBookmark url = barcode.url ?? null;
      String urlTilte = (barcode.url == null) ? '' : barcode.url.title;
      _listBarcodeItems.add(
        new BarcodeItem(
          imagenBase64: img64, 
          codigo: raw, 
          tipoCodigo: type, 
          tituloUrl: urlTilte, 
          url: url, 
          areaDeCodigo: barcode.boundingBox, 
          puntosEsquinas: barcode.cornerPoints
        )
      );
    }
    return barcodes.isEmpty;
  }
}
