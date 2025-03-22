import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkr/features/suppliers/data/models/suppliermodel/datum.dart';
import 'package:mkr/features/suppliers/data/models/supplierrequest.dart';
import 'package:mkr/features/suppliers/data/repos/supplierrepoimp.dart';

part 'supplier_state.dart';

class supplierCubit extends Cubit<supplierState> {
  supplierCubit(this.supplierrepoim) : super(supplierInitial());
  final supplierrepoimp supplierrepoim;
  List<Datum> suppliers = [];
  addcoponent({required supplierrequest supplier}) async {
    emit(addsupplierloading());
    var result = await supplierrepoim.addsupplier(supplier: supplier);
    result.fold((failure) {
      emit(addsupplierfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addsuppliersuccess(successmessage: Success));
    });
  }

  editcoponent({required supplierrequest supplier, required int id}) async {
    emit(editsupplierloading());
    var result = await supplierrepoim.editsupplier(supplier: supplier, id: id);
    result.fold((failure) {
      emit(editsupplierfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(editsuppliersuccess(successmessage: Success));
    });
  }

  deletesupplier({required int supplierid}) async {
    emit(deletesupplierloading());
    var result = await supplierrepoim.deletsupplier(supplierid: supplierid);
    result.fold((failure) {
      emit(deletesupplierfailure(errormessage: failure.error_message));
    }, (Success) {
      suppliers.removeWhere((e) {
        return e.id == supplierid;
      });
      emit(deletesuppliersuccess(successmessage: Success));
    });
  }

  getsuppliers() async {
    emit(getsupplierloading());
    var result = await supplierrepoim.getsuppliers();
    result.fold((failure) {
      emit(getsupplierfailure(errormessage: failure.error_message));
    }, (Success) {
      suppliers = Success.data!;
      emit(getsuppliersuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }
}
