import 'package:flutter/material.dart';

class Customtableattendanceitemmove extends StatelessWidget {
  final String type;
  final String date;
  final String time;

  final TextStyle textStyle;

  const Customtableattendanceitemmove(
      {super.key,
      required this.type,
      required this.date,
      required this.time,
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
              date,
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
              type,
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
                time,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
