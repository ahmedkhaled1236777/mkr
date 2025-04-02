import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:mkr/core/common/widgets/loading.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:mkr/core/common/widgets/showdialogerror.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:mkr/features/workers/presentation/views/addworker.dart';
import 'package:mkr/features/workers/presentation/views/widgets/alertsearch.dart';
import 'package:mkr/features/workers/presentation/views/widgets/customworkertimeritem.dart';
import 'package:mkr/features/workers/presentation/views/widgets/editworker.dart';
import 'package:mkr/features/workers/presentation/views/widgets/workeritem.dart';

class worker extends StatefulWidget {
  @override
  State<worker> createState() => _workerState();
}

class _workerState extends State<worker> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final workerheader = [
    "اسم الموظف",
    "رقم الهاتف",
    "الوظيفه",
    "الراتب",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<WorkersCubit>(context).getworkers();
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
                    onPressed: () async {
                      await BlocProvider.of<WorkersCubit>(context).getworkers();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<DateCubit>(context).cleardates();
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              title: Container(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: appcolors.maincolor,
                                    )),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.all(35),
                              content: Alertworkersearch(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "الموظفين",
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
                    children: workerheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<WorkersCubit, WorkersState>(
                      listener: (context, state) {
                if (state is getworkerfailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
              }, builder: (context, state) {
                if (state is getworkerloading) return loadingshimmer();
                if (state is getworkerfailure)
                  return errorfailure(
                    errormessage: state.errormessage,
                  );
                else {
                  if (BlocProvider.of<WorkersCubit>(context).workers.isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onDoubleTap: () {},
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Container(
                                            alignment: Alignment.topLeft,
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  color: appcolors.maincolor,
                                                )),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          content: Workeritem(
                                              componentitem:
                                                  BlocProvider.of<WorkersCubit>(
                                                          context)
                                                      .workers[i]));
                                    });
                              },
                              child: Customworkeritem(
                                  job: BlocProvider.of<WorkersCubit>(context)
                                      .workers[i]
                                      .jobTitle!,
                                  salary: BlocProvider.of<WorkersCubit>(context)
                                      .workers[i]
                                      .salary!,
                                  workerphone:
                                      BlocProvider.of<WorkersCubit>(context)
                                              .workers[i]
                                              .phone ??
                                          "",
                                  workername:
                                      BlocProvider.of<WorkersCubit>(context)
                                          .workers[i]
                                          .name!,
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  edit: IconButton(
                                      color:
                                          const Color.fromARGB(255, 9, 62, 88),
                                      onPressed: () {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('editworker')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          BlocProvider.of<DateCubit>(context)
                                                  .date2 =
                                              BlocProvider.of<WorkersCubit>(
                                                      context)
                                                  .workers[i]
                                                  .employmentDate!;

                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  title: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: appcolors
                                                              .maincolor,
                                                        )),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  backgroundColor: Colors.white,
                                                  insetPadding:
                                                      EdgeInsets.all(35),
                                                  content: editworkerdialog(
                                                      name: TextEditingController(
                                                          text: BlocProvider.of<WorkersCubit>(context)
                                                              .workers[i]
                                                              .name),
                                                      jop: TextEditingController(
                                                          text: BlocProvider.of<WorkersCubit>(context)
                                                              .workers[i]
                                                              .jobTitle),
                                                      workhours:
                                                          TextEditingController(
                                                              text: BlocProvider.of<WorkersCubit>(context)
                                                                  .workers[i]
                                                                  .workedHours),
                                                      salary: TextEditingController(
                                                          text: BlocProvider.of<WorkersCubit>(context)
                                                              .workers[i]
                                                              .salary),
                                                      phone: TextEditingController(
                                                          text:
                                                              BlocProvider.of<WorkersCubit>(context)
                                                                  .workers[i]
                                                                  .phone),
                                                      id: BlocProvider.of<WorkersCubit>(context)
                                                          .workers[i]
                                                          .id!),
                                                );
                                              });
                                        }
                                      },
                                      icon: Icon(editeicon)),
                                  delete: IconButton(
                                      onPressed: () {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('deleteworker')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  WorkersCubit, WorkersState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is deleteworkersuccess) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes,
                                                        context: context);
                                                  }
                                                  if (state
                                                      is deleteworkerfailure) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message:
                                                            state.errormessage,
                                                        toaststate:
                                                            Toaststate.error,
                                                        context: context);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is deleteworkerloading)
                                                    return deleteloading();
                                                  return SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        style:
                                                            const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          37,
                                                                          163,
                                                                          42)),
                                                        ),
                                                        onPressed: () async {
                                                          await BlocProvider.of<
                                                                      WorkersCubit>(
                                                                  context)
                                                              .deleteworker(
                                                                  workerid: BlocProvider.of<
                                                                              WorkersCubit>(
                                                                          context)
                                                                      .workers[
                                                                          i]
                                                                      .id!);
                                                        },
                                                        child: const Text(
                                                          "تاكيد",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "cairo",
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                  );
                                                },
                                              ),
                                              tittle: "هل تريد الحذف ؟");
                                        }
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<WorkersCubit>(context)
                            .workers
                            .length);
                  }
                }
              })),
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
                          if (!cashhelper
                              .getdata(key: "permessions")
                              .contains('addworker')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(context: context, page: Addworker());
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
