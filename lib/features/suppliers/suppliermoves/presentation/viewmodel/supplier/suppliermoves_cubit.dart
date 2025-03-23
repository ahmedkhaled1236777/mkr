import 'package:bloc/bloc.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermovemodel/datum.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermoverequest.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/repos/suppliermoverepoimp.dart';

part 'suppliermoves_state.dart';

class suppliermovesCubit extends Cubit<suppliermovesState> {
  suppliermovesCubit(this.suppliermoverepoim) : super(suppliermovesInitial());
  final suppliermoverepoimp suppliermoverepoim;
  List<datummoves> datamoves = [];
  List<bool> checks = [];
  int page = 1;

  bool loading = false;
  bool firstloading = false;
  addsuppliermovemove({required suppliermoverequest suppliermove}) async {
    emit(addsuppliermoveloading());
    var result =
        await suppliermoverepoim.addsuppliermove(suppliermove: suppliermove);
    result.fold((failure) {
      emit(addsuppliermovefailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addsuppliermovesuccess(successmessage: Success));
    });
  }

  changecheckbox(bool val, int i) {
    checks[i] = val;
    emit(changecheck());
  }

  deletesuppliermove({required int moveid}) async {
    emit(deletesuppliermoveloading());
    var result = await suppliermoverepoim.deletsuppliermove(moveid: moveid);
    result.fold((failure) {
      emit(deletesuppliermovefailure(errormessage: failure.error_message));
    }, (Success) {
      datamoves.removeWhere((e) {
        return e.id == moveid;
      });
      emit(deletesuppliermovesuccess(successmessage: Success));
    });
  }

  getsuppliermoves({required int clienid}) async {
    if (firstloading == false) emit(getsuppliermoveloading());
    this.page = 1;

    var result = await suppliermoverepoim.getsuppliersmoves(
      page: page,
      supplierid: clienid,
    );
    loading = true;
    result.fold((failue) {
      emit(getsuppliermovefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        loading = false;
      }
      datamoves.clear();
      checks.clear();

      firstloading = true;
      success.data!.forEach((e) {
        datamoves.add(e);
        checks.add(false);
      });

      emit(getsuppliermovesuccess(successmessage: ""));
    });
  }

  getamoresuppliers({required int supplierid}) async {
    page++;
    var result = await suppliermoverepoim.getsuppliersmoves(
      page: page,
      supplierid: supplierid,
    );
    loading = true;
    result.fold((failue) {
      emit(getsuppliermovefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        loading = false;
      }
      success.data!.forEach((e) {
        datamoves.add(e);
        checks.add(false);
      });
      emit(getsuppliermovesuccess(successmessage: ""));
    });
  }
}
