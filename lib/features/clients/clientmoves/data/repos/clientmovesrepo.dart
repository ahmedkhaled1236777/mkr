import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/clients/clientmoves/data/models/clientmovemodel/clientmovemodel.dart';
import 'package:mkr/features/clients/clientmoves/data/models/clientmoverequest.dart';

abstract class clientmovesrepo {
  Future<Either<failure, String>> addclientmove(
      {required Clientmoverequest clientmove});
  /* Future<Either<failure, String>> addclientmove(
      {required clientmoverequest comp});*/

  Future<Either<failure, String>> deletclientmove({required int moveid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, Clientmovemodel>> getclientsmoves(
      {required int clientid, required int page});
  /* Future<Either<failure, clientmovemoddel>> getclientsmoves(
      {required int compid, required int page});*/
}
