import 'dart:io';

import 'package:mkr/features/users/data/models/addemployeerequest.dart';
import 'package:mkr/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'addemployee_state.dart';

class AddemployeeCubit extends Cubit<AddemployeeState> {
  final userrepoimp addemployeerepo;
  AddemployeeCubit({required this.addemployeerepo})
      : super(AddemployeeInitial());
  File? image;
  String? is_active;
  String? manager;
  uploadimage() async {
    XFile? pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      image = File(pickedimage!.path);
      emit(changeprofileimage());
    }
  }

  resetimage() {
    image = null;
    emit(changeprofileimage());
  }

  bool loading = false;
  List headertable = [
    "اسم الموظف",
    "الوظيفه",
    "رقم الهاتف",
    "الحاله",
    "تعديل",
    "حذف"
  ];

  List<String> selecteditems = [];
  getselecteditems() {
    List<String> employeepermession = [];

    for (int i = 0; i < selecteditems.length; i++) {
      employeepermession.add(selecteditems[i]);
    }
    if (!employeepermession.contains("settings"))
      employeepermession.add("settings");
    return employeepermession;
  }

  addemployee(
      {required String token, required addemployeemodel employee}) async {
    emit(Addemployeeloading());
    var result =
        await addemployeerepo.addemployee(token: token, employee: employee);
    result.fold((failure) {
      emit(Addemployeefailure(error_message: failure.error_message));
    }, (succes) {
      emit(Addemployeesuccess(succes_message: succes));
    });
  }

  updateemployee(
      {required String token, required editemployeemodel employee}) async {
    emit(updateemployeeloading());
    var result =
        await addemployeerepo.editemployee(token: token, employee: employee);
    result.fold(
        (l) => {emit(updateemployeefailure(errormessage: l.error_message))},
        (r) => {emit(updateemployeesuccess(succes_message: r))});
  }

  resetdata() {
    selecteditems = [];
    image = null;
    emit(resetdatastate());
  }

  changestatus(String val) {
    this.is_active = val;
    emit(changestatusstate());
  }

  changemanager(String val) {
    this.manager = val;
    emit(changestatusstate());
  }
}
