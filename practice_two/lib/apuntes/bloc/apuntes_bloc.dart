import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica_dos/models/apunte.dart';
import 'package:path/path.dart' as Path;

part 'apuntes_event.dart';
part 'apuntes_state.dart';

class ApuntesBloc extends Bloc<ApuntesEvent, ApuntesState> {
  final Firestore _firestoreInstance = Firestore.instance;
  List<Apunte> _apuntesList;
  List<DocumentSnapshot> _documentsList;
  List<Apunte> get getApuntesList => _apuntesList;

  @override
  ApuntesState get initialState => ApuntesInitial();

  @override
  Stream<ApuntesState> mapEventToState(
    ApuntesEvent event,
  ) async* {
    if (event is GetDataEvent) {
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se ha podido conseguir datos.",
        );
    } else if (event is SaveDataEvent) {
      bool saved = await _saveApunte(
        event.materia,
        event.descripcion,
        event.imageUrl,
      );
      if (saved) {
        await _getData();
        yield CloudStoreSaved();
      } else
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente guardar mas tarde.",
        );
    } else if (event is RemoveDataEvent) {
      try {
        await _documentsList[event.index].reference.delete();
        _documentsList.removeAt(event.index);
        _apuntesList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    } else if (event is ChooseImageEvent) {
      File chosenImg = await _chooseImage();
      if ( chosenImg != null) {
          yield ChosenImageLoaded(imgPath: chosenImg);
      } else {
          yield ChosenImageFailed();
      }
    } else if (event is UploadFileEvent) {
        dynamic url = await _uploadFile(event.file);
        if (url != null) {
            yield FileUploaded(fileUrl: url);
        } else {
            yield FileUploadFailed();
        }
    }
  }

  Future<bool> _getData() async {
    try {
      var apuntes =
          await _firestoreInstance.collection("apuntes").getDocuments();
      _apuntesList = apuntes.documents
          .map(
            (apunte) => Apunte(
              materia: apunte["materia"],
              descripcion: apunte["descripcion"],
              imageUrl: apunte["imagen"],
            ),
          )
          .toList();
      _documentsList = apuntes.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveApunte(
    String materia,
    String descripcion,
    String imageUrl,
  ) async {
    try {
      await _firestoreInstance.collection("apuntes").document().setData({
        "materia": materia,
        "descripcion": descripcion,
        "imagen": imageUrl,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

    Future<File> _chooseImage() async {
      File img = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 720,
        maxWidth: 720,
      );
      return img;
  }

   Future<dynamic> _uploadFile(File file) async {
    String filePath = file.path;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("apuntes/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    
    dynamic imageUrl = await taskSnapshot.ref.getDownloadURL();
    // .then((imageUrl) {
    // });
    print("Link>>>>> $imageUrl");


    dynamic fileUrl = await reference.getDownloadURL();
    // .then((fileURL) {
    //   print("$fileURL");
    //   setState(() {
    //     _url = fileURL;
    //     _saveData();
    //   });
    // });
    return fileUrl;
  }
}
