import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

class Attendancecuibt extends Cubit<Attendancestate> {
  Attendancecuibt() : super(attendanceintial());
  List<String> status = [
    "حضور",
    "حضور",
    "حضور",
    "حضور",
    "حضور",
    "حضور",
    "حضور",
    "حضور",
    "حضور",
    "حضور",
  ];
  List<String> workersnames = [
    "أحمد علي",
    "محمد علي",
    "محمود علي",
    "سيد علي",
    "خالد علي",
    "سعيد علي",
    "وليد علي",
    "ثروت علي",
    "اسماء علي",
    "ايمان علي",
  ];
  changeattendancestatus({required String value, required int index}) {
    status[index] = value;
    emit(changestatus());
  }
}
