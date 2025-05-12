class supplierrequest {
  final String name;
  final String phone;
  final String? pay;
  final String? process;
  final String destination;
  supplierrequest(
      {required this.name,
      required this.phone,
      this.pay,
      this.process,
      required this.destination});
  tojson() => {
        "name": name,
        "phone": phone,
        "destination": destination,
        if (pay != null) "pay": pay,
        if (process != null) "process": process
      };
}
