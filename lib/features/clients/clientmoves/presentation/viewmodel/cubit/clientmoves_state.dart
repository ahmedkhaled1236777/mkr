part of 'clientmoves_cubit.dart';

abstract class ClientmovesState {}

class ClientmovesInitial extends ClientmovesState {}

class changeprodstste extends ClientmovesState {}

class changetypestate extends ClientmovesState {}

class changecheck extends ClientmovesState {}

class addclientmoveloading extends ClientmovesState {}

class addclientmovesuccess extends ClientmovesState {
  final String successmessage;

  addclientmovesuccess({required this.successmessage});
}

class addclientmovefailure extends ClientmovesState {
  final String errormessage;

  addclientmovefailure({required this.errormessage});
}

class deleteclientmoveloading extends ClientmovesState {}

class deleteclientmovesuccess extends ClientmovesState {
  final String successmessage;

  deleteclientmovesuccess({required this.successmessage});
}

class deleteclientmovefailure extends ClientmovesState {
  final String errormessage;

  deleteclientmovefailure({required this.errormessage});
}

class getclientmoveloading extends ClientmovesState {}

class getclientmovesuccess extends ClientmovesState {
  final String successmessage;

  getclientmovesuccess({required this.successmessage});
}

class getclientmovefailure extends ClientmovesState {
  final String errormessage;

  getclientmovefailure({required this.errormessage});
}
