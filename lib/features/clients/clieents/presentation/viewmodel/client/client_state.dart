part of 'client_cubit.dart';

abstract class clientState {}

class clientInitial extends clientState {}

class changeclientnamestate extends clientState {}

class changematerialstate extends clientState {}

class addclientloading extends clientState {}

class addclientsuccess extends clientState {
  final String successmessage;

  addclientsuccess({required this.successmessage});
}

class addclientfailure extends clientState {
  final String errormessage;

  addclientfailure({required this.errormessage});
}

class deleteclientloading extends clientState {}

class deleteclientsuccess extends clientState {
  final String successmessage;

  deleteclientsuccess({required this.successmessage});
}

class deleteclientfailure extends clientState {
  final String errormessage;

  deleteclientfailure({required this.errormessage});
}

class getclientloading extends clientState {}

class getclientsuccess extends clientState {
  final String successmessage;

  getclientsuccess({required this.successmessage});
}

class getclientfailure extends clientState {
  final String errormessage;

  getclientfailure({required this.errormessage});
}

class editclientloading extends clientState {}

class editclientsuccess extends clientState {
  final String successmessage;

  editclientsuccess({required this.successmessage});
}

class editclientfailure extends clientState {
  final String errormessage;

  editclientfailure({required this.errormessage});
}

class editclientmoveloading extends clientState {}

class editclientmovesuccess extends clientState {
  final String successmessage;

  editclientmovesuccess({required this.successmessage});
}

class editclientmovefailure extends clientState {
  final String errormessage;

  editclientmovefailure({required this.errormessage});
}
