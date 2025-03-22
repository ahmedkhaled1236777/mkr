abstract class fullprodState {}

class fullprodInitial extends fullprodState {}

class changeprodstste extends fullprodState {}

class changetypestate extends fullprodState {}

class addnewimagestate extends fullprodState {}

class changematerialstate extends fullprodState {}

class packtypechange extends fullprodState {}

class addfullprodloading extends fullprodState {}

class addfullprodsuccess extends fullprodState {
  final String successmessage;

  addfullprodsuccess({required this.successmessage});
}

class addfullprodfailure extends fullprodState {
  final String errormessage;

  addfullprodfailure({required this.errormessage});
}

class addfullprodmoveloading extends fullprodState {}

class addfullprodmovesuccess extends fullprodState {
  final String successmessage;

  addfullprodmovesuccess({required this.successmessage});
}

class addfullprodmovefailure extends fullprodState {
  final String errormessage;

  addfullprodmovefailure({required this.errormessage});
}

class deletefullprodloading extends fullprodState {}

class deletefullprodsuccess extends fullprodState {
  final String successmessage;

  deletefullprodsuccess({required this.successmessage});
}

class deletefullprodfailure extends fullprodState {
  final String errormessage;

  deletefullprodfailure({required this.errormessage});
}

class deletefullprodmoveloading extends fullprodState {}

class deletefullprodmovesuccess extends fullprodState {
  final String successmessage;

  deletefullprodmovesuccess({required this.successmessage});
}

class deletefullprodmovefailure extends fullprodState {
  final String errormessage;

  deletefullprodmovefailure({required this.errormessage});
}

class getfullprodloading extends fullprodState {}

class getfullprodsuccess extends fullprodState {
  final String successmessage;

  getfullprodsuccess({required this.successmessage});
}

class getfullprodfailure extends fullprodState {
  final String errormessage;

  getfullprodfailure({required this.errormessage});
}

class getfullprodmoveloading extends fullprodState {}

class getfullprodmovesuccess extends fullprodState {
  final String successmessage;

  getfullprodmovesuccess({required this.successmessage});
}

class getfullprodmovefailure extends fullprodState {
  final String errormessage;

  getfullprodmovefailure({required this.errormessage});
}

class editfullprodloading extends fullprodState {}

class editfullprodsuccess extends fullprodState {
  final String successmessage;

  editfullprodsuccess({required this.successmessage});
}

class editfullprodfailure extends fullprodState {
  final String errormessage;

  editfullprodfailure({required this.errormessage});
}

class editfullprodmoveloading extends fullprodState {}

class editfullprodmovesuccess extends fullprodState {
  final String successmessage;

  editfullprodmovesuccess({required this.successmessage});
}

class editfullprodmovefailure extends fullprodState {
  final String errormessage;

  editfullprodmovefailure({required this.errormessage});
}
