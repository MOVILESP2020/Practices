import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica_dos/contact/bloc/contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String attachment;
  bool isHTML = false;
  final _recipientController = TextEditingController(
    text: "isaaccabrera31@gmail.com"
  );
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ContactBloc bloc;

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPath: attachment,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        bloc = ContactBloc();
        return bloc;
      },
      child: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ChoseImageFailed) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se pudo cargar la imagen."),
                  ),
                );
          } else if (state is SendEmailFailed) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se pudo evniar el correo."),
                  ),
                );
          } else if (state is SendEmailSucced) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Correo enviado"),
                  ),
                );     
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ChoseImageSucced) {
              attachment = state.image;
            }
            if (state is SendEmailSucced) {
              _bodyController.clear();
              _subjectController.clear();
              attachment = null;
              isHTML = false;
            }
            return generateContactPage() ;
          },
        ),
      )
    );
  }

  Widget generateContactPage() {
    final Widget imagePath = Text(attachment ?? '');
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Contacto'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                final Email email = Email(
                  body: _bodyController.text,
                  subject: _subjectController.text,
                  recipients: [_recipientController.text],
                  attachmentPath: attachment,
                  isHTML: isHTML,
                );
                bloc.add(SendEmailEvent(email: email));
              },
              icon: Icon(Icons.send),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _recipientController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipient',
                        hintText: 'example@example.com'
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                        hintText: 'The subject'
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _bodyController,
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: 'Hello...',
                          labelText: 'Body',
                          border: OutlineInputBorder()
                          ),
                        
                    ),
                  ),
                  CheckboxListTile(
                    title: Text('HTML'),
                    onChanged: (bool value) {
                      setState(() {
                        isHTML = value;
                      });
                    },
                    value: isHTML,
                  ),
                  imagePath,
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera),
          label: Text('Add Image'),
          onPressed: () {
            bloc.add(ChoseImageEvent());
          },
          heroTag: UniqueKey(),
        ),
      );
  }

}
