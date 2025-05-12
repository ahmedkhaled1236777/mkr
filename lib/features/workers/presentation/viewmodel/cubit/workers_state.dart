part of 'workers_cubit.dart';

sealed class WorkersState {}

class WorkersInitial extends WorkersState {}

class addworkerloading extends WorkersState {}

class addworkersuccess extends WorkersState {
  final String successmessage;

  addworkersuccess({required this.successmessage});
}

class addworkerfailure extends WorkersState {
  final String errormessage;

  addworkerfailure({required this.errormessage});
}

class deleteworkerloading extends WorkersState {}

class deleteworkersuccess extends WorkersState {
  final String successmessage;

  deleteworkersuccess({required this.successmessage});
}

class deleteworkerfailure extends WorkersState {
  final String errormessage;

  deleteworkerfailure({required this.errormessage});
}

class getworkerloading extends WorkersState {}

class getworkersuccess extends WorkersState {
  final String successmessage;

  getworkersuccess({required this.successmessage});
}

class getworkerfailure extends WorkersState {
  final String errormessage;

  getworkerfailure({required this.errormessage});
}

class getworkermovesloading extends WorkersState {}

class getworkermovessuccess extends WorkersState {
  final String successmessage;

  getworkermovessuccess({required this.successmessage});
}

class getworkermovesfailure extends WorkersState {
  final String errormessage;

  getworkermovesfailure({required this.errormessage});
}

class editworkerloading extends WorkersState {}

class changeworkerstate extends WorkersState {}

class editworkersuccess extends WorkersState {
  final String successmessage;

  editworkersuccess({required this.successmessage});
}

class editworkerfailure extends WorkersState {
  final String errormessage;

  editworkerfailure({required this.errormessage});
}
