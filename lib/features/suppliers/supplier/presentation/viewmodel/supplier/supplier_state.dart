part of 'supplier_cubit.dart';

abstract class supplierState {}

class supplierInitial extends supplierState {}

class changematerialstate extends supplierState {}

class addsupplierloading extends supplierState {}

class addsuppliersuccess extends supplierState {
  final String successmessage;

  addsuppliersuccess({required this.successmessage});
}

class addsupplierfailure extends supplierState {
  final String errormessage;

  addsupplierfailure({required this.errormessage});
}

class deletesupplierloading extends supplierState {}

class deletesuppliersuccess extends supplierState {
  final String successmessage;

  deletesuppliersuccess({required this.successmessage});
}

class deletesupplierfailure extends supplierState {
  final String errormessage;

  deletesupplierfailure({required this.errormessage});
}

class getsupplierloading extends supplierState {}

class getsuppliersuccess extends supplierState {
  final String successmessage;

  getsuppliersuccess({required this.successmessage});
}

class getsupplierfailure extends supplierState {
  final String errormessage;

  getsupplierfailure({required this.errormessage});
}

class editsupplierloading extends supplierState {}

class editsuppliersuccess extends supplierState {
  final String successmessage;

  editsuppliersuccess({required this.successmessage});
}

class editsupplierfailure extends supplierState {
  final String errormessage;

  editsupplierfailure({required this.errormessage});
}
