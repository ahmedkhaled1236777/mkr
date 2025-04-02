abstract class Attendancestate {}

class attendanceintial extends Attendancestate {}

class changestatus extends Attendancestate {}

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
