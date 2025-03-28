import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/users/data/models/addemployeerequest.dart';
import 'package:mkr/features/users/data/models/employeemodel/employeemodel.dart';
import 'package:dartz/dartz.dart';

abstract class userrepo {
  Future<Either<failure, String>> addemployee(
      {required String token, required addemployeemodel employee});
  Future<Either<failure, Employeemodel>> getemployees({required String token});
  Future<Either<failure, String>> deleteemployee({required int employeenumber});
  Future<Either<failure, String>> editemployee(
      {required String token, required editemployeemodel employee});
}
