import 'package:flutter/material.dart';

class Customtableattendanceitem extends StatelessWidget {
  final String employeename;
  final String attendancedays;
  final String weekenddays;
  final String notattendacedays;
  final String permessionhours;
  final String salary;

  final TextStyle textStyle;

  const Customtableattendanceitem(
      {super.key,
      required this.employeename,
      required this.attendancedays,
      required this.weekenddays,
      required this.notattendacedays,
      required this.permessionhours,
      required this.salary,
      required this.textStyle});

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
            child: Text(
              employeename,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: Text(
              attendancedays,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                weekenddays,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                notattendacedays,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                permessionhours,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                salary,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
