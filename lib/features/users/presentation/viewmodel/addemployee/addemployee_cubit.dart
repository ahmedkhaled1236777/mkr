import 'dart:io';

import 'package:mkr/features/users/data/models/addemployeerequest.dart';
import 'package:mkr/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'addemployee_state.dart';

class AddemployeeCubit extends Cubit<AddemployeeState> {
  final emplyeerepoimplementaion addemployeerepo;
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
  Map permessions = {
    'الحقن': "injections",
    'اوردرات الحقن': "injections_order",
    'تصنيع الاسطمبات': "stamp_manufacturing",
    'الموظفين': "employees",
    'المستخدمين': "users",
    'العملاء': "customers",
    'الموردين': "suppliers",
    'مخزن الخامات': "material_store",
    'مخزن الاكسسوارات': "accessories_store",
    "مخزن المكونات": "components_store",
    "المحافظ الالكترونيه": "wallets",
    "الخزينه": "save",
    'مخزن ادوات المصنع': "warehouse",
    'الاعدادات': "settings",
  };
  Map showpermessions = {
    "injections": 'الحقن',
    "injections_order": 'اوردرات الحقن',
    "stamp_manufacturing": 'تصنيع الاسطمبات',
    "employees": 'الموظفين',
    "users": "المستخدمين",
    "customers": 'العملاء',
    "suppliers": 'الموردين',
    "material_store": 'مخزن الخامات',
    "accessories_store": 'مخزن الاكسسوارات',
    "components_store": "مخزن المكونات",
    "wallets": "المحافظ الالكترونيه",
    "save": "الخزينه",
    "warehouse": 'مخزن ادوات المصنع',
    "settings": 'الاعدادات',
  };
  List<String> selecteditems = [];
  getselecteditems() {
    List<String> employeepermession = [];
    employeepermession.add("settings");
    for (int i = 0; i < selecteditems.length; i++) {
      if (selecteditems[i] == "الاشعارات" || selecteditems[i] == "الاعدادات") {
        continue;
      }
      employeepermession.add(permessions[selecteditems[i]]);
    }
    return employeepermession;
  }

  showselecteditems(List<dynamic> permessions) {
    selecteditems = [];
    for (int i = 0; i < permessions.length; i++) {
      if (showpermessions[permessions[i]] != null &&
          !selecteditems.contains(permessions[i]))
        selecteditems.add(showpermessions[permessions[i]]);
    }
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
