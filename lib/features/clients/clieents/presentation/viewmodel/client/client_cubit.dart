import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mkr/features/clients/clieents/data/models/clientmodel/datum.dart';
import 'package:mkr/features/clients/clieents/data/models/clientrequest.dart';
import 'package:mkr/features/clients/clieents/data/repos/clientrepoimp.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<clientState> {
  ClientCubit(this.clientrepoimp) : super(clientInitial());
  final Clientrepoimp clientrepoimp;
  List<Datum> clients = [];
  Map<String, dynamic>? queryparma;
  addcoponent({required Clientrequest client}) async {
    emit(addclientloading());
    var result = await clientrepoimp.addclient(client: client);
    result.fold((failure) {
      emit(addclientfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(addclientsuccess(successmessage: Success));
    });
  }

  editcoponent({required Clientrequest client, required int id}) async {
    emit(editclientloading());
    var result = await clientrepoimp.editclient(client: client, id: id);
    result.fold((failure) {
      emit(editclientfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(editclientsuccess(successmessage: Success));
    });
  }

  deleteclient({required int clientid}) async {
    emit(deleteclientloading());
    var result = await clientrepoimp.deletclient(clientid: clientid);
    result.fold((failure) {
      emit(deleteclientfailure(errormessage: failure.error_message));
    }, (Success) {
      clients.removeWhere((e) {
        return e.id == clientid;
      });
      emit(deleteclientsuccess(successmessage: Success));
    });
  }

  getclients() async {
    emit(getclientloading());
    var result = await clientrepoimp.getclients(queryparma: queryparma);
    result.fold((failure) {
      emit(getclientfailure(errormessage: failure.error_message));
    }, (Success) {
      clients = Success.data!;
      emit(getclientsuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }
}
