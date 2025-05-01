class Clientrequest {
  final String name;
  final String phone;
  final String maden;
  final String daen;
  final String place;
  Clientrequest(
      {required this.name,
      required this.phone,
      required this.daen,
      required this.maden,
      required this.place});
  tojson() => {
        "name": name,
        "phone": phone,
        "pay": daen,
        "process": maden,
        "destination": place
      };
}

class Clientrequest2 {
  final String name;
  final String phone;

  final String place;
  Clientrequest2(
      {required this.name, required this.phone, required this.place});
  tojson() => {"name": name, "phone": phone, "destination": place};
}
