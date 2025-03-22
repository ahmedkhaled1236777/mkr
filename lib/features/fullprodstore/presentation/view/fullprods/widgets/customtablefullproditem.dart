import 'package:flutter/material.dart';

class Customtablefullproditem extends StatelessWidget {
  final String fullprodname;
  final String packtype;
  final String pieceprice;
  final String quantity;
  final String alarm;
  final Color color;
  final Widget edit;
  final Widget delete;

  final TextStyle textStyle;

  Customtablefullproditem(
      {super.key,
      required this.fullprodname,
      required this.color,
      required this.pieceprice,
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
              fullprodname,
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
              pieceprice,
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
              flex: 2,
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
