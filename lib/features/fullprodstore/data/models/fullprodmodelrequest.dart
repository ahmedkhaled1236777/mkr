import 'package:dio/dio.dart';

class fullprodmodelrequest {
  final String fullprodname;
  final String quantity;
  final String alarmqty;
  final String price;
  final String packtype;
  final String qtyinpack;
  dynamic? image;

  fullprodmodelrequest(
      {required this.fullprodname,
      required this.quantity,
      required this.alarmqty,
      this.image,
      required this.price,
      required this.packtype,
      required this.qtyinpack});
  FormData tojson() => FormData.fromMap({
        if (image != null) "image": image,
        "name": fullprodname,
        "qty": quantity,
        "price_unit": price,
        "packaging_type": packtype,
        "units_per_packaging": qtyinpack,
        "warning_qty": alarmqty,
      });
}
