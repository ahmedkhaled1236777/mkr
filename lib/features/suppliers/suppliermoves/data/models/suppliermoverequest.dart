class suppliermoverequest {
  final int supplierid;
  final String date;
  String? qty;
  int? componentid;
  final String notes;
  final String price;
  final String status;

  suppliermoverequest(
      {required this.supplierid,
      required this.date,
      required this.notes,
      required this.status,
      this.componentid,
      required this.price,
      this.qty});
  tojson() => {
        "supplier_id": supplierid,
        "date": date,
        "price": price,
        "notes": notes,
        if (qty != null) "qty": qty,
        if (componentid != null) "stock_id": componentid,
        "status": status
      };
}
