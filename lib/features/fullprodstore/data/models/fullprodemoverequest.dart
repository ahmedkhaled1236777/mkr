class fullprodmoverequest {
  final int warehouse_id;
  final String status;
  final String date;
  final String qty;
  final String discount_percentage;
  final String name_of_client;
  final String notes;

  fullprodmoverequest(
      {required this.warehouse_id,
      required this.status,
      required this.date,
      required this.qty,
      required this.discount_percentage,
      required this.name_of_client,
      required this.notes});
  tojson() => {
        "warehouse_id": warehouse_id,
        "status": status,
        "date": date,
        "discount_percentage": discount_percentage,
        "qty": qty,
        "name_of_client": name_of_client,
        "notes": notes,
      };
}
