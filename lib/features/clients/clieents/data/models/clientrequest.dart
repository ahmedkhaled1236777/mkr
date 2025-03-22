class Clientrequest {
  final String name;
  final String phone;
  Clientrequest({required this.name, required this.phone});
  tojson() => {"name": name, "phone": phone};
}
