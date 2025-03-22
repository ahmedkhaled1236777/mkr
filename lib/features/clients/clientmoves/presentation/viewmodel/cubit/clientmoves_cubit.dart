import 'package:bloc/bloc.dart';
import 'package:mkr/features/clients/clientmoves/data/models/clientmovemodel/datum.dart';
import 'package:mkr/features/clients/clientmoves/data/models/clientmoverequest.dart';
import 'package:mkr/features/clients/clientmoves/data/repos/clientmoverepoimp.dart';

part 'clientmoves_state.dart';

class ClientmovesCubit extends Cubit<ClientmovesState> {
  ClientmovesCubit(this.clientmoverepoimp) : super(ClientmovesInitial());
  final Clientmoverepoimp clientmoverepoimp;
  List<datummoves> datamoves = [];
  List<bool> checks = [];
  int page = 1;

  bool loading = false;
  bool firstloading = false;
  addclientmovemove({required Clientmoverequest clientmove}) async {
    emit(addclientmoveloading());
    var result = await clientmoverepoimp.addclientmove(clientmove: clientmove);
    result.fold((failure) {
      emit(addclientmovefailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addclientmovesuccess(successmessage: Success));
    });
  }

  changecheckbox(bool val, int i) {
    checks[i] = val;
    emit(changecheck());
  }

  deleteclientmove({required int moveid}) async {
    emit(deleteclientmoveloading());
    var result = await clientmoverepoimp.deletclientmove(moveid: moveid);
    result.fold((failure) {
      emit(deleteclientmovefailure(errormessage: failure.error_message));
    }, (Success) {
      datamoves.removeWhere((e) {
        return e.id == moveid;
      });
      emit(deleteclientmovesuccess(successmessage: Success));
    });
  }

  getclientmoves({required int clienid}) async {
    if (firstloading == false) emit(getclientmoveloading());
    this.page = 1;

    var result = await clientmoverepoimp.getclientsmoves(
      page: page,
      clientid: clienid,
    );
    loading = true;
    result.fold((failue) {
      emit(getclientmovefailure(errormessage: failue.error_message));
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

      emit(getclientmovesuccess(successmessage: ""));
    });
  }

  getamoreclients({required int clientid}) async {
    page++;
    var result = await clientmoverepoimp.getclientsmoves(
      page: page,
      clientid: clientid,
    );
    loading = true;
    result.fold((failue) {
      emit(getclientmovefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        loading = false;
      }
      success.data!.forEach((e) {
        datamoves.add(e);
        checks.add(false);
      });
      emit(getclientmovesuccess(successmessage: ""));
    });
  }
}
