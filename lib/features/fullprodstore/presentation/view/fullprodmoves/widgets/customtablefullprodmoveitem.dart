import 'package:flutter/material.dart';

class Customtablefullprodmoveitem extends StatelessWidget {
  final String date;
  final String qty;
  final String status;

  final Widget delete;

  final TextStyle textStyle;

  Customtablefullprodmoveitem(
      {super.key,
      required this.date,
      required this.textStyle,
      required this.qty,
      required this.status,
      required this.delete});

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
              date,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 3,
            child: Text(
              qty,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                status,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
