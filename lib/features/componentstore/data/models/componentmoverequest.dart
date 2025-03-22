class Componentmoverequest {
  final int stock_id;
  final String status;
  final String date;
  final String qty;
  final String price;
  final String name_of_supplier;
  final String notes;

  Componentmoverequest(
      {required this.stock_id,
      required this.status,
      required this.date,
      required this.qty,
      required this.price,
      required this.name_of_supplier,
      required this.notes});
  tojson() => {
        "stock_id": stock_id,
        "status": status,
        "date": date,
        "qty": qty,
        "price": price,
        "name_of_supplier": name_of_supplier,
        "notes": notes,
      };
}
