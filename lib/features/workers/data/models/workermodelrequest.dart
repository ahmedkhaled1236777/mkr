class Workermodelrequest {
  final String name;
  final String job_title;
  final String employment_date;
  final String workhours;
  final String phone;
  final String hourprice;
  final String salary;

  Workermodelrequest(
      {required this.name,
      required this.job_title,
      required this.employment_date,
      required this.phone,
      required this.hourprice,
      required this.workhours,
      required this.salary});
  tojson() => {
        "name": name,
        "employment_date": employment_date,
        "job_title": job_title,
        "salary": salary,
        "phone": phone,
        "hourly_rate": hourprice,
        "worked_hours": workhours
      };
}
