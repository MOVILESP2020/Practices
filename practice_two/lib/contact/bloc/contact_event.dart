part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class SendEmailEvent extends ContactEvent{
  final Email email;
  SendEmailEvent({@required this.email});
 @override
  List<Object> get props => [email];
}

class ChoseImageEvent extends ContactEvent {
 @override
  List<Object> get props => [];
}
