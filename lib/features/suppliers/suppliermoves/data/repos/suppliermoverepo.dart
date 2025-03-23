import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermovemodel/suppliermovemodel.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermoverequest.dart';

abstract class suppliermovesrepo {
  Future<Either<failure, String>> addsuppliermove(
      {required suppliermoverequest suppliermove});
  /* Future<Either<failure, String>> addsuppliermove(
      {required suppliermoverequest comp});*/

  Future<Either<failure, String>> deletsuppliermove({required int moveid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, Suppliermovemodel>> getsuppliersmoves(
      {required int supplierid, required int page});
  /* Future<Either<failure, suppliermovemoddel>> getsuppliersmoves(
      {required int compid, required int page});*/
}
