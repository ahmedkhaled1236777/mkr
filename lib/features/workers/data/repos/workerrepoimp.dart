import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/errors/handlingerror.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/workers/data/models/workermodel/workermodel.dart';
import 'package:mkr/features/workers/data/models/workermodelrequest.dart';
import 'package:mkr/features/workers/data/repos/workerrepo.dart';

class Workerrepoimp extends Workerrepo {
  @override
  Future<Either<failure, String>> addworker(
      {required Workermodelrequest worker}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.employers,
          queryParameters: worker.tojson());
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
  Future<Either<failure, String>> deletworker({required int workerid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "employers/${workerid}",
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
  Future<Either<failure, String>> editworker(
      {required Workermodelrequest worker, required int id}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "employers/${id}",
          queryParameters: worker.tojson());
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
  }

  @override
  Future<Either<failure, Workermodel>> getworkers(
      {Map<String, dynamic>? queryparma}) async {
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
}
