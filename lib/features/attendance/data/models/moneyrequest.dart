class moneyrequset {
  final String date;
  final String notes;
  final String amount;
  final String type;
  final int employer_id;

  moneyrequset(
      {required this.date,
      required this.notes,
      required this.amount,
      required this.type,
      required this.employer_id});
  tojson() => {
        "date": date,
        "notes": notes,
        "amount": amount,
        "type": type,
        "employer_id": employer_id
      };
}
