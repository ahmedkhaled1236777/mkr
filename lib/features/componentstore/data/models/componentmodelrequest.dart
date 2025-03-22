class Componentmodelrequest {
  final String componentname;
  final String quantity;
  final String alarmqty;
  final String packtype;
  final String qtyinpack;

  Componentmodelrequest(
      {required this.componentname,
      required this.quantity,
      required this.alarmqty,
      required this.packtype,
      required this.qtyinpack});
  tojson() => {
        "name": componentname,
        "qty": quantity,
        "packaging_type": packtype,
        "units_per_packaging": qtyinpack,
        "warning_qty": alarmqty,
      };
}
