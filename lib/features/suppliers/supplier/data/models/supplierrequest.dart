class supplierrequest {
  final String name;
  final String phone;
  supplierrequest({required this.name, required this.phone});
  tojson() => {"name": name, "phone": phone};
}
