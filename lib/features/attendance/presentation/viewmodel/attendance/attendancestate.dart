abstract class Attendancestate {}

class attendanceintial extends Attendancestate {}

class addpermessionloading extends Attendancestate {}

class changepermessionstatus extends Attendancestate {}

class addpermessionsuccess extends Attendancestate {
  final String successmessage;

  addpermessionsuccess({required this.successmessage});
}

class addpermessionfailure extends Attendancestate {
  final String errormessage;

  addpermessionfailure({required this.errormessage});
}

class editattendanceloading extends Attendancestate {}

class editattendencesuccess extends Attendancestate {
  final String successmessage;

  editattendencesuccess({required this.successmessage});
}

class editattendancefailure extends Attendancestate {
  final String errormessage;

  editattendancefailure({required this.errormessage});
}

class changestatus extends Attendancestate {}

class getattendancemoveloading extends Attendancestate {}

class getattendancemovesuccess extends Attendancestate {
  final String successmessage;

  getattendancemovesuccess({required this.successmessage});
}

class getattendancemovefailure extends Attendancestate {
  final String errormessage;

  getattendancemovefailure({required this.errormessage});
}

class addattendanceloading extends Attendancestate {}

class addattendancesuccess extends Attendancestate {
  final String successmessage;

  addattendancesuccess({required this.successmessage});
}

class addattendancefailure extends Attendancestate {
  final String errormessage;

  addattendancefailure({required this.errormessage});
}

class attendanceloading extends Attendancestate {}

class attendancesuccess extends Attendancestate {
  final String successmessage;

  attendancesuccess({required this.successmessage});
}

class attendancefailure extends Attendancestate {
  final String errormessage;

  attendancefailure({required this.errormessage});
}
