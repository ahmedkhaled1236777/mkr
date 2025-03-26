import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mkr/features/componentstore/data/models/componentmodel/datum.dart';
import 'package:mkr/features/componentstore/data/models/componentmodelrequest.dart';
import 'package:mkr/features/componentstore/data/models/componentmovemoddel/datum.dart';
import 'package:mkr/features/componentstore/data/models/componentmoverequest.dart';
import 'package:mkr/features/componentstore/data/repos/componentrepoimp.dart';

part 'component_state.dart';

class ComponentCubit extends Cubit<ComponentState> {
  final Componentrepoimp componentrepoimp;
  ComponentCubit(this.componentrepoimp) : super(ComponentInitial());
  List<Datum> components = [];
  Map<String, dynamic>? queryparms;
  String materialstatus = "0";
  List<datummoves> datamoves = [];
  bool firstloading = false;
  int motionpage = 1;
  bool firstloadingmotion = false;
  bool motionloading = false;
  String productname = "اختر المنتج";
  String type = "0";
  List<String> products = [];
  Map<String, int> productid = {};
  Map<String, dynamic> productpacktype = {};
  String? name_of_supplier;
  String? datefrom;
  String? dateto;
  onpacktypechange() {
    emit(packtypechange());
  }

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

  changematerialstatus(String val) {
    materialstatus = val;
    emit(changematerialstate());
  }

  addcoponent({required Componentmodelrequest component}) async {
    emit(addcomponentloading());
    var result = await componentrepoimp.addcomponent(comp: component);
    result.fold((failure) {
      emit(addcomponentfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addcomponentsuccess(successmessage: Success));
    });
  }

  addcoponentmove({required Componentmoverequest component}) async {
    emit(addcomponentmoveloading());
    var result = await componentrepoimp.addcomponentmove(comp: component);
    result.fold((failure) {
      emit(addcomponentmovefailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addcomponentmovesuccess(successmessage: Success));
    });
  }

  editcoponent(
      {required Componentmodelrequest component, required int id}) async {
    emit(editcomponentloading());
    var result = await componentrepoimp.editcomponent(comp: component, id: id);
    result.fold((failure) {
      emit(editcomponentfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(editcomponentsuccess(successmessage: Success));
    });
  }

  deletecomponent({required int componentid}) async {
    emit(deletecomponentloading());
    var result = await componentrepoimp.deletecomp(compid: componentid);
    result.fold((failure) {
      emit(deletecomponentfailure(errormessage: failure.error_message));
    }, (Success) {
      components.removeWhere((e) {
        return e.id == componentid;
      });
      emit(deletecomponentsuccess(successmessage: Success));
    });
  }

  deletecomponentmove({required int componentmoveid}) async {
    emit(deletecomponentmoveloading());
    var result =
        await componentrepoimp.deletecompmove(compmoveid: componentmoveid);
    result.fold((failure) {
      emit(deletecomponentmovefailure(errormessage: failure.error_message));
    }, (Success) {
      datamoves.removeWhere((e) {
        return e.id == componentmoveid;
      });
      emit(deletecomponentmovesuccess(successmessage: Success));
    });
  }

  getcomponents() async {
    emit(getcomponentloading());
    var result = await componentrepoimp.getcomponents(queryparms: queryparms);
    result.fold((failure) {
      emit(getcomponentfailure(errormessage: failure.error_message));
    }, (Success) {
      products.clear();
      Success.data!.forEach((e) {
        products.add(e.name!);
        productid.addAll({e.name!: e.id!});
        productpacktype.addAll({e.name!: e.packagingType!});
      });
      components = Success.data!;
      emit(getcomponentsuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getcomponentmotion({required int compid}) async {
    if (firstloadingmotion == false) emit(getcomponentmoveloading());
    this.motionpage = 1;
    var result = await componentrepoimp.getcomponentsmoves(
      compid: compid,
      page: motionpage,
      name_of_supplier: name_of_supplier,
      dateto: dateto,
      datefrom: datefrom,
    );
    motionloading = true;
    result.fold((failue) {
      emit(getcomponentmovefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }
      datamoves = success.data!;

      firstloadingmotion = true;

      emit(getcomponentmovesuccess(successmessage: ""));
    });
  }

  getmorecomponentssmotion({required int componentid}) async {
    motionpage++;
    var result = await componentrepoimp.getcomponentsmoves(
      page: motionpage,
      compid: componentid,
      name_of_supplier: name_of_supplier,
      dateto: dateto,
      datefrom: datefrom,
    );
    motionloading = true;
    result.fold((failue) {
      emit(getcomponentmovefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }

      success.data!.forEach((e) {
        datamoves.add(e);
      });
      emit(getcomponentmovesuccess(successmessage: ""));
    });
  }
}
