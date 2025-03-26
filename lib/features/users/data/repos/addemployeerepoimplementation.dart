import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/errors/handlingerror.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/users/data/models/addemployeerequest.dart';
import 'package:mkr/features/users/data/models/employeemodel/employeemodel.dart';
import 'package:mkr/features/users/data/repos/addemployeerepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class emplyeerepoimplementaion extends employeerepo {
  @override
  Future<Either<failure, String>> addemployee(
      {required String token, required addemployeemodel employee}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.adduser, token: token, data: employee.tojson());
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      print(response.data);

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(response.data["message"]);
      } else if (response.statusCode == 200 &&
          response.data["success"] == false) {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
      return left(requestfailure(error_message: response.data["message"]));
    } catch (e) {
      print(e.toString());
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Employeemodel>> getemployees({
    required String token,
  }) async {
    Employeemodel employeesmodel;
    try {
      Response response = await Getdata.getdata(path: urls.users, token: token);
      if (response.statusCode == 200 && response.data["success"] == true) {
        employeesmodel = Employeemodel.fromJson(response.data);
        return right(employeesmodel);
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
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
  Future<Either<failure, String>> deleteemployee(
      {required int employeenumber}) async {
    try {
      Response response = await Postdata.postdata(
          path: "delete-user",
          queryParameters: {"user_id": employeenumber},
          token: cashhelper.getdata(key: "token"));
      if (response.statusCode == 200 && response.data["status"] == true)
        return right("تم حذف البيانات بنجاح");
      else {
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
  Future<Either<failure, String>> editemployee(
      {required String token, required editemployeemodel employee}) async {
    try {
      Response response = await Postdata.postdata(
          path: "update-user", token: token, data: employee.tojson());
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(response.data["message"]);
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
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
}
