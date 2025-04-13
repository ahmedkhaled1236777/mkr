class Attendancepermessionrequest {
  final String status;
  final int employerid;
  final String numberofhours;
  final String date;
  final String notes;

  Attendancepermessionrequest(
      {required this.status,
      required this.employerid,
      required this.numberofhours,
      required this.date,
      required this.notes});
  tojson() => {
        "status": status,
        "employer_id": employerid,
        "number_of_hours": numberofhours,
        "date": date,
        "notes": notes
      };
}
