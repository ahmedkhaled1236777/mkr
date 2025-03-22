import 'package:dio/dio.dart';

class addemployeemodel {
  final String password;
  final String name;
  final String phone;
  final String email;
  final String password_confirmation;
  final String jobtittle;
  final List<String> permessions;

  addemployeemodel({
    required this.password,
    required this.email,
    required this.name,
    required this.password_confirmation,
    required this.jobtittle,
    required this.phone,
    required this.permessions,
  });
  FormData tojson() => FormData.fromMap({
        "email": email,
        "name": name,
        "phone": phone,
        "password_confirmation": password_confirmation,
        "job_title": jobtittle,
        "password": password,
        "permissions[]": permessions,
      });
}

class editemployeemodel {
  final String name;
  final String phone;
  final String email;
  final String userid;
  final String role;
  final String isactive;
  final String jobtittle;
  final List<String> permessions;

  editemployeemodel({
    required this.email,
    required this.name,
    required this.role,
    required this.jobtittle,
    required this.userid,
    required this.isactive,
    required this.phone,
    required this.permessions,
  });
  tojson() => {
        "email": email,
        "name": name,
        "role_id": role,
        "user_id": userid,
        "is_active": isactive,
        "phone": phone,
        "job_title": jobtittle,
        "permissions": permessions,
      };
}
