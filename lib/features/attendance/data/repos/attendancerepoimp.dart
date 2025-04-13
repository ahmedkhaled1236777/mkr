import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/errors/handlingerror.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:mkr/features/attendance/data/models/attendancemovemodel/attendancemovemodel.dart';
import 'package:mkr/features/attendance/data/models/attendancepermessionrequest.dart';
import 'package:mkr/features/attendance/data/repos/attendancerepo.dart';
import 'package:mkr/features/workers/data/models/workermodel/workermodel.dart';

class attendancerepoimp extends attendancerepo {
  @override
  Future<Either<failure, String>> addattendance(
      {required Attendancemodelrequest attendance}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.employermoves,
          data: attendance.tojson());
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم الانشاء بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  /* @override
  Future<Either<failure, String>> deletattendance({required int attendanceid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "employers/${attendanceid}",
      );
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم الحذف بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editattendance(
      {required attendancemodelrequest attendance, required int id}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "employers/${id}",
          queryParameters: attendance.tojson());
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم التعديل بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }*/

  @override
  Future<Either<failure, Workermodel>> getattendances(
      {required Map<String, dynamic> queryparma}) async {
    try {
      Response response = await Getdata.getdata(
          queryParameters: queryparma,
          token: cashhelper.getdata(key: "token"),
          path: urls.employers);
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Workermodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editattendancemove(
      {required String status, required int id}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "${urls.employermoves}/${id}",
          queryParameters: {"status": status});
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم الانشاء بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editpermession(
      {required Attendancepermessionrequest attendance,
      required int id}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "${"permits"}/${id}",
          queryParameters: attendance.tojson());
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم الانشاء بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Attendancemovemodel>> getattendancesemoves(
      {required Map<String, dynamic> queryparma}) async {
    try {
      Response response = await Getdata.getdata(
          queryParameters: queryparma,
          token: cashhelper.getdata(key: "token"),
          path: urls.employermoves);
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Attendancemovemodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
