import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/errors/handlingerror.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/componentstore/data/models/componentmodel/componentmodel.dart';
import 'package:mkr/features/componentstore/data/models/componentmodelrequest.dart';
import 'package:mkr/features/componentstore/data/models/componentmovemoddel/componentmovemodel.dart';
import 'package:mkr/features/componentstore/data/models/componentmoverequest.dart';
import 'package:mkr/features/componentstore/data/repos/componentrepo.dart';

class Componentrepoimp extends Componentrepo {
  @override
  Future<Either<failure, String>> addcomponent(
      {required Componentmodelrequest comp}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.addcomponent,
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
  Future<Either<failure, String>> editcomponent(
      {required Componentmodelrequest comp, required int id}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "stocks/${id}",
          queryParameters: comp.tojson());
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
  Future<Either<failure, String>> deletecomp({required int compid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "stocks/${compid}",
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
  Future<Either<failure, Componentmodel>> getcomponents(
      {Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          queryParameters: queryparms,
          token: cashhelper.getdata(key: "token"),
          path: urls.addcomponent);
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Componentmodel.fromJson(response.data));
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
  Future<Either<failure, String>> addcomponentmove(
      {required Componentmoverequest comp}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.componentmoves,
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
  Future<Either<failure, String>> deletecompmove(
      {required int compmoveid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "stock-moves/${compmoveid}",
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
  Future<Either<failure, Componentmovemoddel>> getcomponentsmoves(
      {required int compid,
      required int page,
      String? name_of_supplier,
      String? datefrom,
      String? dateto}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.componentmoves,
          queryParameters: {
            if (name_of_supplier != null) "name_of_supplier": name_of_supplier,
            if (datefrom != null) "date_from": datefrom,
            if (dateto != null) "date_to": dateto,
            "stock_id": compid,
            "page": page,
          });
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(Componentmovemoddel.fromJson(response.data));
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
