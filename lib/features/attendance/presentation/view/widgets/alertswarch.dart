import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';

class diagramsearch extends StatefulWidget {
  @override
  State<diagramsearch> createState() => _diagramsearchState();
}

class _diagramsearchState extends State<diagramsearch> {
  int? month;

  int? year;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('بحث بواسطة',
                                style: TextStyle(
                                    fontFamily: "cairo",
                                    color: appcolors.maincolor),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                final selected = await showMonthPicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2050),
                                    locale: Locale('ar'));
                                if (selected != null) {
                                  month = selected.month;
                                  year = selected.year;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xff535C91),
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Color(0xff535C91))),
                                child: Center(
                                  child: Text(
                                    month == null
                                        ? "اختر التاريخ"
                                        : "0${month}-${year}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "cairo"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            custommaterialbutton(
                              button_name: "بحث",
                              onPressed: () async {
                                if (month == null) {
                                  showdialogerror(
                                      error: "لابد من اختيار الشهر",
                                      context: context);
                                } else {
                                  Navigator.pop(context);
                                  BlocProvider.of<Attendancecuibt>(context)
                                      .month = month!.toString();
                                  BlocProvider.of<Attendancecuibt>(context)
                                      .year = year!.toString();
                                  await BlocProvider.of<Attendancecuibt>(
                                          context)
                                      .getaattendance(queryparma: {
                                    "month": BlocProvider.of<Attendancecuibt>(
                                            context)
                                        .month,
                                    "year": BlocProvider.of<Attendancecuibt>(
                                            context)
                                        .year
                                  });
                                }
                              },
                            )
                          ]))))
            ])));
  }
}

Future<void> _onPressed({
  required BuildContext context,
  String? locale,
}) async {}
