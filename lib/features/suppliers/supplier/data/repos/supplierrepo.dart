import 'package:dartz/dartz.dart';
import 'package:mkr/core/common/errors/failure.dart';
import 'package:mkr/features/suppliers/supplier/data/models/suppliermodel/suppliermodel.dart';
import 'package:mkr/features/suppliers/supplier/data/models/supplierrequest.dart';

abstract class supplierrepo {
  Future<Either<failure, String>> addsupplier(
      {required supplierrequest supplier});
  /* Future<Either<failure, String>> addsuppliermove(
      {required suppliermoverequest comp});*/
  Future<Either<failure, String>> editsupplier(
      {required supplierrequest supplier, required int id});

  Future<Either<failure, String>> deletsupplier({required int supplierid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, Suppliermodel>> getsuppliers();
  /* Future<Either<failure, suppliermovemoddel>> getsuppliersmoves(
      {required int compid, required int page});*/
}
