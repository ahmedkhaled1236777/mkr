part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class changeobsecurestate extends AuthState {}

class loginloading extends AuthState {}

class loginsuccess extends AuthState {
  final String successmessage;

  loginsuccess({required this.successmessage});
}

class loginfailure extends AuthState {
  final String errormessage;

  loginfailure({required this.errormessage});
}

class updateprofileloading extends AuthState {}

class updateprofilesuccess extends AuthState {
  final Updatemodel success;

  updateprofilesuccess({required this.success});
}

class updateprofilefailure extends AuthState {
  final String errormessage;

  updateprofilefailure({required this.errormessage});
}

class changepassfailure extends AuthState {
  final String errormessage;

  changepassfailure({required this.errormessage});
}

class changepasssuccess extends AuthState {
  final String successmessage;

  changepasssuccess({required this.successmessage});
}

class logoutloading extends AuthState {}

class logoutsuccess extends AuthState {
  final String successmessage;

  logoutsuccess({required this.successmessage});
}

class logoutfailure extends AuthState {
  final String errorrmessage;

  logoutfailure({required this.errorrmessage});
}

class signuploading extends AuthState {}

class signupsuccess extends AuthState {
  final String successmessage;

  signupsuccess({required this.successmessage});
}

class signupfailure extends AuthState {
  final String errorr_message;

  signupfailure({required this.errorr_message});
}
