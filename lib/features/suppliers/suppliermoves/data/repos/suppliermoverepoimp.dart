import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/errors/handlingerror.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermovemodel/suppliermovemodel.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermoverequest.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/repos/suppliermoverepo.dart';

class suppliermoverepoimp extends suppliermovesrepo {
  @override
  Future<Either<failure, String>> addsuppliermove(
      {required suppliermoverequest suppliermove}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.supplierprocesses,
          queryParameters: suppliermove.tojson());
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
  Future<Either<failure, String>> deletsuppliermove(
      {required int moveid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "supplier-processes/${moveid}",
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
  Future<Either<failure, Suppliermovemodel>> getsuppliersmoves(
      {required int supplierid,
      required int page,
      String? datefrom,
      String? dateto}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.supplierprocesses,
          queryParameters: {
            if (datefrom != null) "date_from": datefrom,
            if (dateto != null) "date_to": dateto,
            "page": page,
            "supplier_id": supplierid,
          });
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(Suppliermovemodel.fromJson(response.data));
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
