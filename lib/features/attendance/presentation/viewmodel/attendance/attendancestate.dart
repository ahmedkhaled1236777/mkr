abstract class Attendancestate {}

class attendanceintial extends Attendancestate {}

class changestatus extends Attendancestate {}

class attendanceloading extends Attendancestate {}

class attendancesuccess extends Attendancestate {
  final String successmessage;

  attendancesuccess({required this.successmessage});
}

class attendancefailure extends Attendancestate {
  final String errormessage;

  attendancefailure({required this.errormessage});
}
