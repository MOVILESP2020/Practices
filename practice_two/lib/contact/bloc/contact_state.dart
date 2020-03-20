part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitial extends ContactState {
  @override
  List<Object> get props => [];
}

class SendEmailSucced extends ContactState {
  @override
  List<Object> get props => [];
}

class SendEmailFailed extends ContactState {
  @override
  List<Object> get props => [];
}


class ChoseImageSucced extends ContactState {
  final String image;
  ChoseImageSucced({@required this.image});
  @override
  List<Object> get props => [image];
}

class ChoseImageFailed extends ContactState {
  @override
  List<Object> get props => [];
}
