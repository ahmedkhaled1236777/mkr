import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/workers/data/models/workermodel/workermodel.dart';
import 'package:mkr/features/workers/data/models/workermodelrequest.dart';
import 'package:mkr/features/workers/data/models/workermovemodel/workermovemodel.dart';

abstract class Workerrepo {
  Future<Either<failure, String>> addworker(
      {required Workermodelrequest worker});
  Future<Either<failure, String>> editworker(
      {required Workermodelrequest worker, required int id});

  Future<Either<failure, String>> deletworker({required int workerid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, Workermodel>> getworkers(
      {Map<String, dynamic>? queryparma});
  Future<Either<failure, Workermovemodel>> getworkersmoves(
      {required int workerid, required String month, required String year});
}
