part of 'suppliermoves_cubit.dart';

abstract class suppliermovesState {}

class suppliermovesInitial extends suppliermovesState {}

class changeprodstste extends suppliermovesState {}

class changetypestate extends suppliermovesState {}

class changecheck extends suppliermovesState {}

class addsuppliermoveloading extends suppliermovesState {}

class addsuppliermovesuccess extends suppliermovesState {
  final String successmessage;

  addsuppliermovesuccess({required this.successmessage});
}

class addsuppliermovefailure extends suppliermovesState {
  final String errormessage;

  addsuppliermovefailure({required this.errormessage});
}

class deletesuppliermoveloading extends suppliermovesState {}

class deletesuppliermovesuccess extends suppliermovesState {
  final String successmessage;

  deletesuppliermovesuccess({required this.successmessage});
}

class deletesuppliermovefailure extends suppliermovesState {
  final String errormessage;

  deletesuppliermovefailure({required this.errormessage});
}

class getsuppliermoveloading extends suppliermovesState {}

class getsuppliermovesuccess extends suppliermovesState {
  final String successmessage;

  getsuppliermovesuccess({required this.successmessage});
}

class getsuppliermovefailure extends suppliermovesState {
  final String errormessage;

  getsuppliermovefailure({required this.errormessage});
}
