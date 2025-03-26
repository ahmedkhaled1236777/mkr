import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/componentstore/data/models/componentmodel/componentmodel.dart';
import 'package:mkr/features/componentstore/data/models/componentmodelrequest.dart';
import 'package:mkr/features/componentstore/data/models/componentmovemoddel/componentmovemodel.dart';
import 'package:mkr/features/componentstore/data/models/componentmoverequest.dart';

abstract class Componentrepo {
  Future<Either<failure, String>> addcomponent(
      {required Componentmodelrequest comp});
  Future<Either<failure, String>> addcomponentmove(
      {required Componentmoverequest comp});
  Future<Either<failure, String>> editcomponent(
      {required Componentmodelrequest comp, required int id});

  Future<Either<failure, String>> deletecomp({required int compid});
  Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, Componentmodel>> getcomponents(
      {Map<String, dynamic>? queryparms});
  Future<Either<failure, Componentmovemoddel>> getcomponentsmoves(
      {required int compid,
      required int page,
      String? name_of_supplier,
      String? datefrom,
      String? dateto});
}
