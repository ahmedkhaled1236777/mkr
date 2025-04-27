import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:mkr/features/attendance/data/models/attendancemovemodel/attendancemovemodel.dart';
import 'package:mkr/features/attendance/data/models/attendancepermessionrequest.dart';
import 'package:mkr/features/workers/data/models/workermodel/workermodel.dart';

abstract class attendancerepo {
  Future<Either<failure, String>> addattendance(
      {required Attendancemodelrequest attendance});
  Future<Either<failure, String>> addpermession(
      {required Attendancepermessionrequest permession});
  Future<Either<failure, String>> editattendancemove(
      {required String status, required int id});
  Future<Either<failure, String>> editpermession(
      {required Attendancepermessionrequest attendance, required int id});

  Future<Either<failure, Workermodel>> getattendances(
      {required Map<String, dynamic> queryparma});
  Future<Either<failure, Attendancemovemodel>> getattendancesemoves(
      {required Map<String, dynamic> queryparma});
}
