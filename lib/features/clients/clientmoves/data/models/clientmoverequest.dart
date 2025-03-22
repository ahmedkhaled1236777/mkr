class Clientmoverequest {
  final int clientid;
  final String date;
  String? qty;
  int? fullprodid;
  final String notes;
  String? price;
  String? discount_percentage;
  final String status;

  Clientmoverequest(
      {required this.clientid,
      required this.date,
      required this.notes,
      required this.status,
      this.fullprodid,
      this.discount_percentage,
      this.price,
      this.qty});
  tojson() => {
        "client_id": clientid,
        "date": date,
        if (price != null) "price": price,
        if (discount_percentage != null)
          "discount_percentage": discount_percentage,
        "notes": notes,
        if (qty != null) "qty": qty,
        if (fullprodid != null) "warehouse_id": fullprodid,
        "status": status
      };
}
