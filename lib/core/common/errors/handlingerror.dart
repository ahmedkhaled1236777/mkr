import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:dio/dio.dart';
import 'package:mkr/features/auth/login/presentation/view/login.dart';

// ignore: camel_case_type
class requestfailure extends failure {
  // ignore: non_constant_identifier_names
  requestfailure({required super.error_message}) {
    if (super.error_message == "تم تسجيل الخروج من التطبيق") {
      cashhelper.cleardata();
      Get.offAll(Login(),
          transition: Transition.rightToLeft,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut);
    }
  }
  factory requestfailure.fromdioexception(DioException dioException) {
    print("llllllllllllllllllllllll");
    print(dioException.message);
    print(dioException.response);
    print(dioException.error.toString());
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return requestfailure(error_message: "لقد انتهي وقت الاتصال");
      case DioExceptionType.sendTimeout:
        return requestfailure(error_message: "لقد انتهي وقت الارسال");
      case DioExceptionType.receiveTimeout:
        return requestfailure(error_message: "لقد انتهي وقت الارسال");
      case DioExceptionType.badCertificate:
        return requestfailure(error_message: "يوجد خطأ برجاء المحاوله لاحقا");
      case DioExceptionType.badResponse:
        return requestfailure.fromresponse(
            dioException.response!.statusCode!, dioException.response!.data!);
      case DioExceptionType.cancel:
        return requestfailure(error_message: "انتهي وقت محاولة الاتصال");

      case DioExceptionType.connectionError:
        return requestfailure(error_message: "يوجد مشكله في الاتصال");

      case DioExceptionType.unknown:
        if (dioException.message!.contains("SocketException")) {
          return requestfailure(
              error_message: "يوجد مشكله في الاتصال بالانترنت");
        } else {
          return requestfailure(
              error_message: "يوجد خطأ برجاء المحاوله مره اخري");
        }
      default:
        return requestfailure(
            error_message: "يوجد خطأ برجاء المحاوله مره اخري");
    }
  }
  factory requestfailure.fromresponse(int statuscode, dynamic respnse) {
    if (statuscode == 422 || statuscode == 400 || statuscode == 403) {
      return requestfailure(error_message: respnse["data"]["message"]);
    } else if (statuscode == 401) {
      return requestfailure(error_message: "تم تسجيل الخروج من التطبيق");
    } else if (statuscode == 404) {
      return requestfailure(error_message: "الصفحه غير موجوده");
    } else if (statuscode == 500)
      // ignore: curly_braces_in_flow_control_structures
      return requestfailure(error_message: "يوجد مشكله في السيرفر");
    else
      // ignore: curly_braces_in_flow_control_structures
      return requestfailure(error_message: "برجاء المحاوله مره اخري");
  }
}
