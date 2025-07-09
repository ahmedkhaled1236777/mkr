import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:mkr/features/attendance/data/models/attendancemovemodel/datum.dart';
import 'package:mkr/features/attendance/data/models/attendancepermessionrequest.dart';
import 'package:mkr/features/attendance/data/models/moneymodel/datum.dart';
import 'package:mkr/features/attendance/data/models/moneyrequest.dart';
import 'package:mkr/features/attendance/data/repos/attendancerepoimp.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

import '../../../../workers/data/models/workermodel/datum.dart';

class Attendancecuibt extends Cubit<Attendancestate> {
  Attendancecuibt(this.attendancerepo) : super(attendanceintial());
  final attendancerepoimp attendancerepo;
  List<Datum> attendances = [];
  List<datamoves> employeeattendances = [];
  List<moneymoves> moneys = [];
  List<String> status = [];
  List<String> workersnames = [];
  String? month;
  String? year;
  String? attendancestatus;
  String date = "${DateTime.now().month}-${DateTime.now().year}";
  String moneyname = "credit";
  String permessionstatus = "0";
  changedate(String value) {
    date = value;
    emit(changedatestate());
  }

  changemoneytype(String value) {
    moneyname = value;
    emit(changemoneytypestate());
  }

  changepermessiontype(String value) {
    permessionstatus = value;
    emit(changepermessionstatus());
  }

  changeattendancestatus({required String value, required int index}) {
    status[index] = value;
    emit(changestatus());
  }

  editchangeattendancestatus({required String value}) {
    attendancestatus = value;
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

  addmoney({required moneyrequset money}) async {
    emit(addmoneyloading());
    var result = await attendancerepo.addmoney(moneyrequest: money);
    result.fold((failure) {
      emit(addmoneyfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addmoneysuccess(successmessage: success));
    });
  }

  deletemoney({required int id}) async {
    emit(deletemoneyloading());
    var result = await attendancerepo.deletemoney(id: id);
    result.fold((failure) {
      emit(deletemoneyfailure(errormessage: failure.error_message));
    }, (success) {
      moneys.removeWhere((e) {
        return e.id == id;
      });
      emit(deletemoneysuccess(successmessage: success));
    });
  }

  addpermession({required Attendancepermessionrequest permession}) async {
    emit(addpermessionloading());
    var result = await attendancerepo.addpermession(permession: permession);
    result.fold((failure) {
      emit(addpermessionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addpermessionsuccess(successmessage: success));
    });
  }

  editattendance({required String status, required int id}) async {
    emit(editattendanceloading());
    var result =
        await attendancerepo.editattendancemove(status: status, id: id);
    result.fold((failure) {
      emit(editattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editattendencesuccess(successmessage: success));
    });
  }

  editpermession(
      {required Attendancepermessionrequest attendance,
      required int id}) async {
    emit(editattendanceloading());
    var result =
        await attendancerepo.editpermession(attendance: attendance, id: id);
    result.fold((failure) {
      emit(editattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editattendencesuccess(successmessage: success));
    });
  }

  getaattendance({required Map<String, dynamic> queryparma}) async {
    emit(attendanceloading());
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
      emit(attendancesuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getaattendanceemployermoves(
      {required Map<String, dynamic> queryparma}) async {
    emit(getattendancemoveloading());
    var result =
        await attendancerepo.getattendancesemoves(queryparma: queryparma);
    result.fold((failure) {
      emit(getattendancemovefailure(errormessage: failure.error_message));
    }, (Success) {
      emit(getattendancemovesuccess(
          successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getmoneymoves({required Map<String, dynamic> queryparma}) async {
    emit(getmoneymoveloading());
    var result = await attendancerepo.getmoney(queryparma: queryparma);
    result.fold((failure) {
      emit(getmoneymovefailure(errormessage: failure.error_message));
    }, (Success) {
      moneys = Success.data!;
      emit(getmoneymovesuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getsalary(Datum data) {
    if ((data.totalAttendance! + data.totalVacation!+data.totalAbsence!) == 31) {
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
                  data.totalPermissions!) +
              (((double.parse(data.salary!) / 30) /
                      double.parse(data.workedHours!)) *
                  data.totalExtraTime!) -
              double.parse(data.credit!) -
              double.parse(data.debit!))
          .ceil()
          .toString();
    }
  }

  editatttendancemove({required String status, required int id}) async {
    emit(editattendanceloading());
    var result =
        await attendancerepo.editattendancemove(status: status, id: id);
    result.fold((failure) {
      emit(editattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editattendencesuccess(successmessage: success));
    });
  }
}
