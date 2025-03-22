import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmodel/fullprodmodel.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmodelrequest.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodemoverequest.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmovemodel/fullprodmovemodel.dart';

abstract class fullprodrepo {
  Future<Either<failure, String>> addfullprod(
      {required fullprodmodelrequest comp});
  Future<Either<failure, String>> addfullprodmove(
      {required fullprodmoverequest comp});
  Future<Either<failure, String>> editfullprod(
      {required fullprodmodelrequest comp, required int id});

  Future<Either<failure, String>> deletefullprod({required int compid});
  Future<Either<failure, String>> deletefullprodmove({required int compmoveid});
  Future<Either<failure, Fullprodmodel>> getfullprods();
  Future<Either<failure, Fullprodmovemodel>> getfullprodsmoves(
      {required int compid, required int page});
}
