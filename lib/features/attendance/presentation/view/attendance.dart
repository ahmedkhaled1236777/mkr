import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:flutter/material.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:mkr/features/attendance/presentation/view/addattendance.dart';
import 'package:mkr/features/attendance/presentation/view/widgets/customtableattendanceitem.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

class attendance extends StatefulWidget {
  @override
  State<attendance> createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final attendanceheader = [
    "اسم\nالموظف",
    "ايام\nالحضور",
    "ايام\nالغياب",
    "ايام\nالاجازه",
    "ساعات\nالاذن",
    "الراتب",
  ];

  getdata() async {
    await BlocProvider.of<Attendancecuibt>(context).getaattendance(queryparma: {
      "month": DateTime.now().month,
      "year": DateTime.now().year
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
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () async {},
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "حضور وانصراف الموظفين لشهر  ${DateTime.now().month}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: attendanceheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "ايام\nالحضور" ||
                                      e == "ايام\nالغياب" ||
                                      e == "ايام\nالاجازه" ||
                                      e == "ساعات\nالاذن"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(child: BlocBuilder<Attendancecuibt, Attendancestate>(
                builder: (context, state) {
                  if (state is attendanceloading) return loadingshimmer();
                  if (state is attendancefailure)
                    return errorfailure(errormessage: state.errormessage);
                  return BlocProvider.of<Attendancecuibt>(context)
                          .attendances
                          .isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                child: Customtableattendanceitem(
                                    employeename:
                                        BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .name!,
                                    attendancedays:
                                        BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .totalAttendance
                                            .toString(),
                                    weekenddays:
                                        BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .totalVacation
                                            .toString(),
                                    notattendacedays:
                                        BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .totalAbsence
                                            .toString(),
                                    permessionhours:
                                        BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .totalPermissions
                                            .toString(),
                                    salary: BlocProvider.of<Attendancecuibt>(context)
                                        .getsalary(
                                            BlocProvider.of<Attendancecuibt>(context)
                                                .attendances[i]),
                                    textStyle: Styles.gettabletextstyle(context: context)),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<Attendancecuibt>(context)
                              .attendances
                              .length);
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: appcolors.primarycolor,
                        borderRadius: BorderRadius.circular(7)),
                    child: IconButton(
                        onPressed: () async {
                          navigateto(context: context, page: Addattendance());
                        },
                        icon: Icon(
                          color: Colors.white,
                          Icons.add,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ])));
  }
}
