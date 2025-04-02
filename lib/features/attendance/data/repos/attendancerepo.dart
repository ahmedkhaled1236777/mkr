import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:mkr/features/workers/data/models/workermodel/workermodel.dart';

abstract class attendancerepo {
  Future<Either<failure, String>> addattendance(
      {required Attendancemodelrequest attendance});
  /*Future<Either<failure, String>> editattendancemove(
      {required Attendancemodelrequest attendance, required int id});

  Future<Either<failure, String>> deletattendancemove({required int attendanceid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});*/
  Future<Either<failure, Workermodel>> getattendances(
      {required Map<String, dynamic> queryparma});
}
