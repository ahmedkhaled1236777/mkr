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
import 'package:mkr/core/common/widgets/thousand.dart';
import 'package:mkr/features/clients/clieents/presentation/view/addclient.dart';
import 'package:mkr/features/clients/clieents/presentation/view/pdf/pdf.dart';
import 'package:mkr/features/clients/clieents/presentation/view/widgets/alertsearch.dart';
import 'package:mkr/features/clients/clieents/presentation/view/widgets/customclienttimeritem.dart';
import 'package:mkr/features/clients/clieents/presentation/view/widgets/editclient.dart';
import 'package:mkr/features/clients/clieents/presentation/viewmodel/client/client_cubit.dart';
import 'package:mkr/features/clients/clientmoves/presentation/view/clientactions.dart';

class client extends StatefulWidget {
  @override
  State<client> createState() => _clientState();
}

class _clientState extends State<client> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final clientheader = [
    "اسم العميل",
    "رقم الهاتف",
    "مدين",
    "دائن",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<ClientCubit>(context).queryparma = null;

    await BlocProvider.of<ClientCubit>(context).getclients();
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
                      BlocProvider.of<ClientCubit>(context).queryparma = null;
                      await BlocProvider.of<ClientCubit>(context).getclients();
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
                              content: Alertsearch(),
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
                "العملاء",
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
                    children: clientheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<ClientCubit, clientState>(
                      listener: (context, state) {
                if (state is getclientfailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
              }, builder: (context, state) {
                if (state is getclientloading) return loadingshimmer();
                if (state is getclientfailure)
                  return errorfailure(
                    errormessage: state.errormessage,
                  );
                else {
                  if (BlocProvider.of<ClientCubit>(context).clients.isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onDoubleTap: () {},
                              onTap: () {
                                if (!cashhelper
                                    .getdata(key: "permessions")
                                    .contains('showclientmove')) {
                                  showdialogerror(
                                      error: "ليس لديك الصلاحيه",
                                      context: context);
                                } else {
                                  navigateto(
                                      context: context,
                                      page: clientmoves(
                                        clientid: BlocProvider.of<ClientCubit>(
                                                context)
                                            .clients[i]
                                            .id!,
                                        clientname:
                                            BlocProvider.of<ClientCubit>(
                                                    context)
                                                .clients[i]
                                                .name!,
                                      ));
                                }
                              },
                              child: Customclientitem(
                                  maden: gettext(
                                      value: double.parse(BlocProvider.of<ClientCubit>(context).clients[i].totalProcess!) > double.parse(BlocProvider.of<ClientCubit>(context).clients[i].totalPaid!)
                                          ? (double.parse(BlocProvider.of<ClientCubit>(context).clients[i].totalProcess!) - double.parse(BlocProvider.of<ClientCubit>(context).clients[i].totalPaid!))
                                              .toStringAsFixed(1)
                                          : "0"),
                                  daen: gettext(
                                      value: double.parse(BlocProvider.of<ClientCubit>(context).clients[i].totalPaid!) >
                                              double.parse(
                                                  BlocProvider.of<ClientCubit>(context)
                                                      .clients[i]
                                                      .totalProcess!)
                                          ? (double.parse(BlocProvider.of<ClientCubit>(context).clients[i].totalPaid!) -
                                                  double.parse(
                                                      BlocProvider.of<ClientCubit>(context).clients[i].totalProcess!))
                                              .toStringAsFixed(1)
                                          : "0"),
                                  clientphone: BlocProvider.of<ClientCubit>(context).clients[i].phone!,
                                  clientname: BlocProvider.of<ClientCubit>(context).clients[i].name!,
                                  textStyle: Styles.gettabletextstyle(context: context),
                                  edit: IconButton(
                                      color: const Color.fromARGB(255, 9, 62, 88),
                                      onPressed: () {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('editclient')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Container(
                                                    height: 20,
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
                                                  content: editclientdialog(
                                                      clientname:
                                                          TextEditingController(
                                                              text: BlocProvider
                                                                      .of<ClientCubit>(
                                                                          context)
                                                                  .clients[i]
                                                                  .name),
                                                      phone: TextEditingController(
                                                          text: BlocProvider.of<
                                                                      ClientCubit>(
                                                                  context)
                                                              .clients[i]
                                                              .phone),
                                                      id: BlocProvider.of<
                                                                  ClientCubit>(
                                                              context)
                                                          .clients[i]
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
                                            .contains('deleteclient')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  ClientCubit, clientState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is deleteclientsuccess) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes,
                                                        context: context);
                                                  }
                                                  if (state
                                                      is deleteclientfailure) {
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
                                                      is deleteclientloading)
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
                                                                      ClientCubit>(
                                                                  context)
                                                              .deleteclient(
                                                                  clientid: BlocProvider.of<
                                                                              ClientCubit>(
                                                                          context)
                                                                      .clients[
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
                        itemCount: BlocProvider.of<ClientCubit>(context)
                            .clients
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
                              .contains('clientspdf')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else {
                            double totalpay = 0;
                            double totalprocess = 0;
                            for (int i = 0;
                                i <
                                    BlocProvider.of<ClientCubit>(context)
                                        .clients
                                        .length;
                                i++) {
                              totalprocess = totalprocess +
                                  double.parse(
                                      BlocProvider.of<ClientCubit>(context)
                                          .clients[i]
                                          .totalProcess!);
                              totalpay = totalpay +
                                  double.parse(
                                      BlocProvider.of<ClientCubit>(context)
                                          .clients[i]
                                          .totalPaid!);
                            }
                            final img = await rootBundle
                                .load('assets/images/logo.jpeg');
                            final imageBytes = img.buffer.asUint8List();
                            File file = await clientpdf.generatepdf(
                              categories:
                                  BlocProvider.of<ClientCubit>(context).clients,
                              maden: totalprocess >= totalpay
                                  ? (totalprocess - totalpay).toStringAsFixed(1)
                                  : "0",
                              daen: totalpay >= totalprocess
                                  ? (totalpay - totalprocess).toStringAsFixed(1)
                                  : "0",
                              imageBytes: imageBytes,
                            );
                            clientpdf.openfile(file);
                          }
                        },
                        icon: const Icon(
                          color: Colors.white,
                          Icons.picture_as_pdf,
                        )),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
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
                              .contains('addclient')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          }
                          navigateto(context: context, page: addclient());
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
