import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodemoverequest.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmodel/datum.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmodelrequest.dart';
import 'package:mkr/features/fullprodstore/data/repos/fullprodtrpoimp.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';

import '../../../data/models/fullprodmovemodel/datum.dart';

class fullprodCubit extends Cubit<fullprodState> {
  final fullprodrepoimp fullprodrepoim;
  fullprodCubit(this.fullprodrepoim) : super(fullprodInitial());
  List<Datum> fullprods = [];
  Map<String, dynamic>? queryparams;
  String materialstatus = "0";
  List<datummoves> datamoves = [];
  bool firstloading = false;
  int motionpage = 1;
  bool firstloadingmotion = false;
  bool motionloading = false;
  List<String> products = [];
  Map<String, int> productid = {};
  Map<String, dynamic> productpacktype = {};
  String productname = "اختر المنتج";
  String type = "0";
  String? name_of_client;
  String? datefrom;
  String? dateto;
  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  String packtype = "";
  changeproduct(String value) {
    productname = value;
    emit(changeprodstste());
  }

  resetprodname() {
    productname = "اختر المنتج";
    ;
    emit(changeprodstste());
  }

  onpacktypechange() {
    emit(packtypechange());
  }

  changematerialstatus(String val) {
    materialstatus = val;
    emit(changematerialstate());
  }

  addfullprod({required fullprodmodelrequest fullprod}) async {
    emit(addfullprodloading());
    var result = await fullprodrepoim.addfullprod(comp: fullprod);
    result.fold((failure) {
      emit(addfullprodfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addfullprodsuccess(successmessage: Success));
    });
  }

  addfullprodmove({required fullprodmoverequest fullprod}) async {
    emit(addfullprodmoveloading());
    var result = await fullprodrepoim.addfullprodmove(comp: fullprod);
    result.fold((failure) {
      emit(addfullprodmovefailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addfullprodmovesuccess(successmessage: Success));
    });
  }

  editfullprod(
      {required fullprodmodelrequest fullprod, required int id}) async {
    emit(editfullprodloading());
    var result = await fullprodrepoim.editfullprod(comp: fullprod, id: id);
    result.fold((failure) {
      emit(editfullprodfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(editfullprodsuccess(successmessage: Success));
    });
  }

  deletefullprod({required int fullprodid}) async {
    emit(deletefullprodloading());
    var result = await fullprodrepoim.deletefullprod(compid: fullprodid);
    result.fold((failure) {
      emit(deletefullprodfailure(errormessage: failure.error_message));
    }, (Success) {
      fullprods.removeWhere((e) {
        return e.id == fullprodid;
      });
      emit(deletefullprodsuccess(successmessage: Success));
    });
  }

  deletefullprodmove({required int fullprodmoveid}) async {
    emit(deletefullprodmoveloading());
    var result =
        await fullprodrepoim.deletefullprodmove(compmoveid: fullprodmoveid);
    result.fold((failure) {
      emit(deletefullprodmovefailure(errormessage: failure.error_message));
    }, (Success) {
      datamoves.removeWhere((e) {
        return e.id == fullprodmoveid;
      });
      emit(deletefullprodmovesuccess(successmessage: Success));
    });
  }

  getfullprods() async {
    emit(getfullprodloading());
    var result = await fullprodrepoim.getfullprods(queryparams: queryparams);
    result.fold((failure) {
      emit(getfullprodfailure(errormessage: failure.error_message));
    }, (Success) {
      products.clear();
      Success.data!.forEach((e) {
        products.add(e.name!);
        productid.addAll({e.name!: e.id!});
        productpacktype.addAll({e.name!: e.packagingType!});
      });
      fullprods = Success.data!;
      emit(getfullprodsuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getfullprodmotion({required int compid}) async {
    print("llllllllllllllllllllllllllll");
    print(name_of_client);
    if (firstloadingmotion == false) emit(getfullprodmoveloading());
    this.motionpage = 1;
    var result = await fullprodrepoim.getfullprodsmoves(
        compid: compid,
        page: motionpage,
        datefrom: datefrom,
        dateto: dateto,
        name_of_client: name_of_client);
    motionloading = true;
    result.fold((failue) {
      emit(getfullprodmovefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }
      datamoves = success.data!;

      firstloadingmotion = true;

      emit(getfullprodmovesuccess(successmessage: ""));
    });
  }

  uploadimage() async {
    XFile? pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      image = File(pickedimage!.path);
      emit(addnewimagestate());
    }
  }

  File? image;

  resetimage() {
    image = null;
    emit(addnewimagestate());
  }

  getmorefullprodssmotion({required int fullprodid}) async {
    motionpage++;
    var result = await fullprodrepoim.getfullprodsmoves(
        datefrom: datefrom,
        dateto: dateto,
        name_of_client: name_of_client,
        page: motionpage,
        compid: fullprodid);
    motionloading = true;

    result.fold((failue) {
      emit(getfullprodmovefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }

      success.data!.forEach((e) {
        datamoves.add(e);
      });
      emit(getfullprodmovesuccess(successmessage: ""));
    });
  }
}
