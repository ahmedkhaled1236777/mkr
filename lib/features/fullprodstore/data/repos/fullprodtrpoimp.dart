import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/errors/handlingerror.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodemoverequest.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmodel/fullprodmodel.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmodelrequest.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmovemodel/fullprodmovemodel.dart';
import 'package:mkr/features/fullprodstore/data/repos/fullprodrepo.dart';

class fullprodrepoimp extends fullprodrepo {
  @override
  Future<Either<failure, String>> addfullprod(
      {required fullprodmodelrequest comp}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.fullprod,
          data: comp.tojson());
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
  Future<Either<failure, String>> editfullprod(
      {required fullprodmodelrequest comp, required int id}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "warehouses/${id}",
          data: comp.tojson());
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
  Future<Either<failure, String>> deletefullprod({required int compid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "warehouses/${compid}",
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
  Future<Either<failure, Fullprodmodel>> getfullprods(
      {Map<String, dynamic>? queryparams}) async {
    try {
      Response response = await Getdata.getdata(
          queryParameters: queryparams,
          token: cashhelper.getdata(key: "token"),
          path: urls.fullprod);
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Fullprodmodel.fromJson(response.data));
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
  Future<Either<failure, String>> addfullprodmove(
      {required fullprodmoverequest comp}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.fullprodmoves,
          queryParameters: comp.tojson());
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
  Future<Either<failure, String>> deletefullprodmove(
      {required int compmoveid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "warehouse-moves/${compmoveid}",
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
  Future<Either<failure, Fullprodmovemodel>> getfullprodsmoves(
      {required int compid,
      required int page,
      String? name_of_client,
      String? datefrom,
      String? dateto}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.fullprodmoves,
          queryParameters: {
            if (name_of_client != null) "name_of_client": name_of_client,
            if (datefrom != null) "date_from": datefrom,
            if (dateto != null) "date_to": dateto,
            "warehouse_id": compid,
            "page": page,
          });
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(Fullprodmovemodel.fromJson(response.data));
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
