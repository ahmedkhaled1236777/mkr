import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:flutter/material.dart';
import 'package:mkr/features/attendance/presentation/view/addattendance.dart';
import 'package:mkr/features/attendance/presentation/view/widgets/customtableattendanceitem.dart';

class attendance extends StatefulWidget {
  @override
  State<attendance> createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final attendanceheader = [
    "اسم الموظف",
    "ايام الحضور",
    "ايام الغياب",
    "ايام الاجازه",
    "ساعات الاذن",
    "الراتب",
  ];

  getdata() async {}

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
                              flex: e == "ايام الحضور" ||
                                      e == "ايام الغياب" ||
                                      e == "ايام الاجازه" ||
                                      e == "ساعات الاذن"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, i) => InkWell(
                            onDoubleTap: () {},
                            onTap: () {},
                            child: Customtableattendanceitem(
                                employeename: "محمد احمد",
                                attendancedays: "25",
                                weekenddays: "4",
                                notattendacedays: "1",
                                permessionhours: "0",
                                salary: "1000",
                                textStyle:
                                    Styles.gettabletextstyle(context: context)),
                          ),
                      separatorBuilder: (context, i) => Divider(
                            color: Colors.grey,
                          ),
                      itemCount: 5)),
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
