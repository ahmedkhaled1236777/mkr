class Attendancemodelrequest {
  final String date;
  final List attendance;

  Attendancemodelrequest({required this.date, required this.attendance});
  tojson() => {"date": date, "employers": attendance};
}
