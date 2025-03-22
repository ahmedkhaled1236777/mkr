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

class addsuppliermoveloading extends supplierState {}

class addsuppliermovesuccess extends supplierState {
  final String successmessage;

  addsuppliermovesuccess({required this.successmessage});
}

class addsuppliermovefailure extends supplierState {
  final String errormessage;

  addsuppliermovefailure({required this.errormessage});
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

class deletesuppliermoveloading extends supplierState {}

class deletesuppliermovesuccess extends supplierState {
  final String successmessage;

  deletesuppliermovesuccess({required this.successmessage});
}

class deletesuppliermovefailure extends supplierState {
  final String errormessage;

  deletesuppliermovefailure({required this.errormessage});
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

class getsuppliermoveloading extends supplierState {}

class getsuppliermovesuccess extends supplierState {
  final String successmessage;

  getsuppliermovesuccess({required this.successmessage});
}

class getsuppliermovefailure extends supplierState {
  final String errormessage;

  getsuppliermovefailure({required this.errormessage});
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

class editsuppliermoveloading extends supplierState {}

class editsuppliermovesuccess extends supplierState {
  final String successmessage;

  editsuppliermovesuccess({required this.successmessage});
}

class editsuppliermovefailure extends supplierState {
  final String errormessage;

  editsuppliermovefailure({required this.errormessage});
}
