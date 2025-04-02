import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:mkr/features/attendance/data/repos/attendancerepoimp.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

import '../../../../workers/data/models/workermodel/datum.dart';

class Attendancecuibt extends Cubit<Attendancestate> {
  Attendancecuibt(this.attendancerepo) : super(attendanceintial());
  final attendancerepoimp attendancerepo;
  List<Datum> attendances = [];
  List<String> status = [];
  List<String> workersnames = [];
  bool firstloading = true;
  changeattendancestatus({required String value, required int index}) {
    status[index] = value;
    emit(changestatus());
  }

  addworker({required Attendancemodelrequest attendance}) async {
    emit(addattendanceloading());
    var result = await attendancerepo.addattendance(attendance: attendance);
    result.fold((failure) {
      emit(addattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(addattendancesuccess(successmessage: success));
    });
  }

  getaattendance({required Map<String, dynamic> queryparma}) async {
    if (firstloading) emit(attendanceloading());
    var result = await attendancerepo.getattendances(queryparma: queryparma);
    result.fold((failure) {
      emit(attendancefailure(errormessage: failure.error_message));
    }, (Success) {
      status.clear();
      workersnames.clear();
      attendances.clear();
      Success.data!.forEach((e) {
        attendances.add(e);
        workersnames.add(e.name!);
        status.add("حضور");
      });
      firstloading = false;
      emit(attendancesuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getsalary(Datum data) {
    if ((data.totalAttendance! + data.totalVacation!) == 31) {
      return (int.parse(data.salary!) -
              (((double.parse(data.salary!) / 30) /
                      double.parse(data.workedHours!)) *
                  data.totalPermissions!))
          .ceil()
          .toString();
    } else {
      int totalabsense = 0;
      totalabsense = data.totalVacation! + (data.totalVacation! / 4).floor();
      return ((((data.totalAttendance! + data.totalAbsence!) *
                      (double.parse(data.salary!) / 30)) -
                  (totalabsense * (double.parse(data.salary!) / 30))) -
              (((double.parse(data.salary!) / 30) /
                      double.parse(data.workedHours!)) *
                  data.totalPermissions!))
          .ceil()
          .toString();
    }
  }
}
