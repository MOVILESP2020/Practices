import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  @override
  ContactState get initialState => ContactInitial();

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is ChoseImageEvent) {
      File chosenImg = await _chooseImage();
      if ( chosenImg != null) {
          yield ChoseImageSucced(image: chosenImg.path);
      } else {
          yield ChoseImageFailed();
      }
    } else if (event is SendEmailEvent) {
        try {
          await sendEmail(event.email);
          yield SendEmailSucced();
        } catch(e) {
          print(e.toString());
          yield SendEmailFailed();
        }
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

  Future<void> sendEmail(Email mail) async {
    await FlutterEmailSender.send(mail);
  }

}
