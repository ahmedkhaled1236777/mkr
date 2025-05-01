import 'dart:io';

import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/features/auth/login/data/model/loginrequest.dart';
import 'package:mkr/features/auth/login/data/model/updatemodel/updatemodel.dart';
import 'package:mkr/features/auth/login/data/repos/authrepoimp.dart';
import 'package:bloc/bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Authrepoimp authrepoimp;
  bool obsecure = true;
  changeobsecure() {
    obsecure = !obsecure;
    emit(changeobsecurestate());
  }

  AuthCubit(this.authrepoimp) : super(AuthInitial());
  login({required loginrequest login}) async {
    emit(loginloading());
    var result = await authrepoimp.login(login: login);
    result.fold((failure) {
      emit(loginfailure(errormessage: failure.error_message));
    }, (success) {
      print(success.data);
      cashhelper.setdata(key: "token", value: "Bearer ${success.data!.token!}");
      cashhelper.setdata(key: "name", value: success.data!.user!.name ?? "");
      cashhelper.setdata(
          key: "image",
          value: success.data!.user!.img != null
              ? "${urls.imageurl}${success.data!.user!.img}"
              : "");
      cashhelper.setdata(key: "email", value: success.data!.user!.email ?? "");
      cashhelper.setdata(key: "phone", value: success.data!.user!.phone ?? "");
      cashhelper.setdata(key: "permessions", value: success.data!.permissions!);
      emit(loginsuccess(successmessage: "تم تسجيل الدخول بنجاح"));
    });
  }

  updateprofile(
      {required String email,
      required String phone,
      required String name,
      required String oldpass,
      required String newpass,
      required String newpassconfirm,
      File? photo}) async {
    emit(updateprofileloading());
    var result = await authrepoimp.updateprofile(
        email: email,
        phone: phone,
        name: name,
        photo: photo,
        oldpass: oldpass,
        newpassconfirm: newpassconfirm,
        newpass: newpass);
    result.fold((failure) {
      emit(updateprofilefailure(errormessage: failure.error_message));
    }, (success) {
      emit(updateprofilesuccess(success: success));
    });
  }

  logout() async {
    emit(logoutloading());
    var result = await authrepoimp.logout();
    result.fold((failure) {
      emit(logoutfailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(logoutsuccess(successmessage: success));
    });
  }
}
