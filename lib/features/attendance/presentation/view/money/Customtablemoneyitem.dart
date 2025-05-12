import 'package:flutter/material.dart';
import 'package:mkr/core/colors/colors.dart';

class Customtablemoneyitem extends StatelessWidget {
  final String date;
  final String money;
  final String status;
  final String notes;
  Widget delete;

  TextStyle textStyle = TextStyle(
    fontSize: 12,
    fontFamily: "cairo",
    color: appcolors.maincolor,
  );

  Customtablemoneyitem({
    super.key,
    required this.date,
    required this.notes,
    required this.status,
    required this.money,
    required this.delete,
  });

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 19,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(date, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text(money, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text(status, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text(notes, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
