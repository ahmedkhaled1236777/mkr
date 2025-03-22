import 'package:flutter/material.dart';

class Customtablecomponentitem extends StatelessWidget {
  final String componentname;
  final String packtype;
  final String quantity;
  final String alarm;
  final Color color;
  final Widget edit;
  final Widget delete;

  final TextStyle textStyle;

  Customtablecomponentitem(
      {super.key,
      required this.componentname,
      required this.color,
      required this.alarm,
      required this.packtype,
      required this.textStyle,
      required this.quantity,
      required this.edit,
      required this.delete});

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 19,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              componentname,
              style: double.parse(alarm) >= double.parse(quantity)
                  ? textStyle.copyWith(color: Colors.white)
                  : textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 3,
            child: Text(
              quantity,
              style: double.parse(alarm) >= double.parse(quantity)
                  ? textStyle.copyWith(color: Colors.white)
                  : textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                packtype,
                style: double.parse(alarm) >= double.parse(quantity)
                    ? textStyle.copyWith(color: Colors.white)
                    : textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: edit),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
