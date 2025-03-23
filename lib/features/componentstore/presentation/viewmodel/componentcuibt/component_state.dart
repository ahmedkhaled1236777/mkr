part of 'component_cubit.dart';

abstract class ComponentState {}

class ComponentInitial extends ComponentState {}

class changeprodstste extends ComponentState {}

class changetypestate extends ComponentState {}

class changematerialstate extends ComponentState {}

class packtypechange extends ComponentState {}

class addcomponentloading extends ComponentState {}

class addcomponentsuccess extends ComponentState {
  final String successmessage;

  addcomponentsuccess({required this.successmessage});
}

class addcomponentfailure extends ComponentState {
  final String errormessage;

  addcomponentfailure({required this.errormessage});
}

class addcomponentmoveloading extends ComponentState {}

class addcomponentmovesuccess extends ComponentState {
  final String successmessage;

  addcomponentmovesuccess({required this.successmessage});
}

class addcomponentmovefailure extends ComponentState {
  final String errormessage;

  addcomponentmovefailure({required this.errormessage});
}

class deletecomponentloading extends ComponentState {}

class deletecomponentsuccess extends ComponentState {
  final String successmessage;

  deletecomponentsuccess({required this.successmessage});
}

class deletecomponentfailure extends ComponentState {
  final String errormessage;

  deletecomponentfailure({required this.errormessage});
}

class deletecomponentmoveloading extends ComponentState {}

class deletecomponentmovesuccess extends ComponentState {
  final String successmessage;

  deletecomponentmovesuccess({required this.successmessage});
}

class deletecomponentmovefailure extends ComponentState {
  final String errormessage;

  deletecomponentmovefailure({required this.errormessage});
}

class getcomponentloading extends ComponentState {}

class getcomponentsuccess extends ComponentState {
  final String successmessage;

  getcomponentsuccess({required this.successmessage});
}

class getcomponentfailure extends ComponentState {
  final String errormessage;

  getcomponentfailure({required this.errormessage});
}

class getcomponentmoveloading extends ComponentState {}

class getcomponentmovesuccess extends ComponentState {
  final String successmessage;

  getcomponentmovesuccess({required this.successmessage});
}

class getcomponentmovefailure extends ComponentState {
  final String errormessage;

  getcomponentmovefailure({required this.errormessage});
}

class editcomponentloading extends ComponentState {}

class editcomponentsuccess extends ComponentState {
  final String successmessage;

  editcomponentsuccess({required this.successmessage});
}

class editcomponentfailure extends ComponentState {
  final String errormessage;

  editcomponentfailure({required this.errormessage});
}

class editcomponentmoveloading extends ComponentState {}

class editcomponentmovesuccess extends ComponentState {
  final String successmessage;

  editcomponentmovesuccess({required this.successmessage});
}

class editcomponentmovefailure extends ComponentState {
  final String errormessage;

  editcomponentmovefailure({required this.errormessage});
}
