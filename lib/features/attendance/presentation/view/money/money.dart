import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:mkr/core/common/widgets/loading.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:mkr/core/common/widgets/showdialogerror.dart';
import 'package:mkr/features/attendance/presentation/view/money/Customtablemoneyitem.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

class money extends StatefulWidget {
  final String month;
  final String year;
  final int employerid;

  const money(
      {super.key,
      required this.month,
      required this.year,
      required this.employerid});
  @override
  State<money> createState() => _moneyState();
}

class _moneyState extends State<money> {
  final permessionheader = ["اليوم", "المبلغ", "الحاله", "الملاحظات", "حذف"];

  getdata() async {
    await BlocProvider.of<Attendancecuibt>(context).getmoneymoves(queryparma: {
      "month": widget.month,
      "year": widget.year,
      "employer_id": widget.employerid
    });
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: Text(
            "السلف والخصومات \n لشهر ${widget.month} - ${widget.year}",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              color: appcolors.maincolor.withOpacity(0.7),
              child: Row(
                children: permessionheader
                    .map(
                      (e) => customheadertable(
                        textStyle: Styles.getheadertextstyle(context: context),
                        title: e,
                        flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: BlocBuilder<Attendancecuibt, Attendancestate>(
                builder: (context, state) {
                  if (state is getmoneymoveloading) return loadingshimmer();
                  if (state is getmoneymovefailure)
                    return errorfailure(errormessage: state.errormessage);
                  return BlocProvider.of<Attendancecuibt>(context)
                          .moneys
                          .isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) => Customtablemoneyitem(
                            status: BlocProvider.of<Attendancecuibt>(
                                      context,
                                    ).moneys[i].type ==
                                    "credit"
                                ? "سلفه"
                                : "خصم",
                            date: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).moneys[i].date!.day.toString(),
                            money: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).moneys[i].amount.toString(),
                            notes: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).moneys[i].notes!,
                            delete: IconButton(
                              onPressed: () {
                                awsomdialogerror(
                                  context: context,
                                  mywidget: BlocConsumer<Attendancecuibt,
                                      Attendancestate>(
                                    listener: (context, state) {
                                      if (state is deletemoneysuccess) {
                                        Navigator.pop(context);

                                        showtoast(
                                          message: state.successmessage,
                                          toaststate: Toaststate.succes,
                                          context: context,
                                        );
                                      }
                                      if (state is deletemoneyfailure) {
                                        Navigator.pop(context);

                                        showtoast(
                                          message: state.errormessage,
                                          toaststate: Toaststate.error,
                                          context: context,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is deletemoneyloading)
                                        return deleteloading();
                                      return SizedBox(
                                        height: 50,
                                        width: 100,
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              Color.fromARGB(
                                                255,
                                                37,
                                                163,
                                                42,
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            await BlocProvider.of<
                                                    Attendancecuibt>(context)
                                                .deletemoney(
                                                    id: BlocProvider.of<
                                                                Attendancecuibt>(
                                                            context)
                                                        .moneys[i]
                                                        .id!);
                                          },
                                          child: const Text(
                                            "تاكيد",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "cairo",
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  tittle: "هل تريد الحذف ؟",
                                );
                              },
                              icon: Icon(deleteicon, color: Colors.red),
                            ),
                          ),
                          separatorBuilder: (context, i) =>
                              Divider(color: Colors.grey),
                          itemCount: BlocProvider.of<Attendancecuibt>(
                            context,
                          ).moneys.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
