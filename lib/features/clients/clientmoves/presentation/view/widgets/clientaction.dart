import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mkr/core/colors/colors.dart';

class customtableclientmoveitem extends StatelessWidget {
  final String date;
  final String status;
  final String price;

  Widget check;
  Widget delte;
  TextStyle textStyle;

  customtableclientmoveitem(
      {super.key,
      required this.date,
      required this.textStyle,
      required this.status,
      required this.price,
      required this.check,
      required this.delte});

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 18),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                date,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                status,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                price,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
            flex: 2,
            child: check,
          ),
          Expanded(
            flex: 2,
            child: delte,
          ),
        ],
      ),
    );
  }
}
