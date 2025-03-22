import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:mkr/features/users/presentation/viewmodel/showemployeecuibt/employeestates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/employeemodel/datum.dart';

class showemployeescuibt extends Cubit<showemployeesstates> {
  final emplyeerepoimplementaion employeerepo;
  showemployeescuibt({required this.employeerepo})
      : super(showemployeesintial());
  List<Datum> employeesdata = [];
  List<Datum> filterdata = [];

  getallemployees() async {
    emit(showemployeesloading());
    var result = await employeerepo.getemployees(
      token: cashhelper.getdata(key: "token"),
    );
    result.fold((l) {
      emit(showemployeesfailure(error_message: l.error_message));
    }, (r) {
      employeesdata.clear();
      filterdata.clear();
      employeesdata.addAll(r.data!);
      filterdata.addAll(r.data!);
      emit(showemployeessuccess());
    });
  }

  deleteemployee({required int employeenumber}) async {
    emit(deleteemployeeloading());
    var result =
        await employeerepo.deleteemployee(employeenumber: employeenumber);
    result.fold((failure) {
      emit(deleteemployeefailure(errormessage: failure.error_message));
    }, (success) {
      employeesdata.removeWhere((element) => element.id == employeenumber);
      emit(deleteemployeesuccess(succes_message: success));
    });
  }

  fileralldata() {
    employeesdata.clear();
    employeesdata.addAll(filterdata);
  }

  searchforemployee(String phone) {
    if (phone.isNotEmpty) {
      employeesdata.removeWhere((element) => element.phone != phone);
    }

    emit(deleteemployeesuccess(succes_message: ""));
  }
}
