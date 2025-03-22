import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/clients/clieents/data/models/clientmodel/clientmodel.dart';
import 'package:mkr/features/clients/clieents/data/models/clientrequest.dart';

abstract class clientrepo {
  Future<Either<failure, String>> addclient({required Clientrequest client});
  /* Future<Either<failure, String>> addclientmove(
      {required clientmoverequest comp});*/
  Future<Either<failure, String>> editclient(
      {required Clientrequest client, required int id});

  Future<Either<failure, String>> deletclient({required int clientid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, Clientmodel>> getclients();
  /* Future<Either<failure, clientmovemoddel>> getclientsmoves(
      {required int compid, required int page});*/
}
