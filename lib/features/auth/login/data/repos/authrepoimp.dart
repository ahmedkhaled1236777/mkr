import 'dart:io';

import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/errors/handlingerror.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/auth/login/data/model/loginmodel/loginmodel.dart';
import 'package:mkr/features/auth/login/data/model/loginrequest.dart';
import 'package:mkr/features/auth/login/data/model/updatemodel/updatemodel.dart';
import 'package:mkr/features/auth/login/data/repos/authrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Authrepoimp extends Authrepo {
  @override
  Future<Either<failure, Loginmodel>> login(
      {required loginrequest login}) async {
    try {
      var response =
          await Postdata.postdata(path: urls.login, data: login.tojson());

      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(Loginmodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(requestfailure.fromdioexception(e));
      } else {
        return left(requestfailure(error_message: e.toString()));
      }
    }
  }

  @override
  Future<Either<failure, String>> logout() async {
    try {
      Response response = await Postdata.postdata(
          path: urls.logout, token: cashhelper.getdata(key: "token"));
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right("تم تسجيل الخروج");
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Updatemodel>> updateprofile(
      {required String email,
      required String phone,
      required String name,
      required String oldpass,
      required String newpass,
      required String newpassconfirm,
      File? photo}) async {
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "email": email,
        "phone": phone,
        "password": newpass,
        "password_confirmation": newpassconfirm,
        "old_password": oldpass,
        if (photo != null)
          "img": await MultipartFile.fromFile(photo.path,
              filename: photo.path.split("/").last)
      });
      Response response = await Postdata.postdata(
          path: urls.updateprofile,
          token: cashhelper.getdata(key: "token"),
          data: data);

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Updatemodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(requestfailure.fromdioexception(e));
      } else {
        print(e);
        return left(requestfailure(error_message: e.toString()));
      }
    }
  }
}
