import 'package:mkr/core/common/styles/styles.dart';
import 'package:flutter/material.dart';

class customtableemployeeitem extends StatelessWidget {
  final String employeename;
  final String job;
  final String phone;
  final String status;

  Widget edit;
  Widget delete;
  TextStyle textStyle;
  double iconsize;
  // ignore: non_constant_identifier_names
  customtableemployeeitem(
      {super.key,
      required this.employeename,
      required this.phone,
      required this.status,
      required this.delete,
      required this.job,
      required this.edit,
      this.iconsize = 22,
      this.textStyle = Styles.textStyle12b});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 19),
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
          Expanded(
              flex: 3,
              child: Text(
                job,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                phone,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 2,
              child: Text(
                status,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
            child: edit,
            flex: 2,
          ),
          Expanded(
            child: delete,
            flex: 2,
          ),
        ],
      ),
    );
  }
}
