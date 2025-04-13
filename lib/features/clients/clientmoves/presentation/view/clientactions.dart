import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:mkr/core/common/widgets/loading.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:mkr/core/common/widgets/showdialogerror.dart';
import 'package:mkr/features/clients/clieents/presentation/viewmodel/client/client_cubit.dart';
import 'package:mkr/features/clients/clientmoves/data/models/clientmovemodel/datum.dart';
import 'package:mkr/features/clients/clientmoves/presentation/view/addaction.dart';
import 'package:mkr/features/clients/clientmoves/presentation/view/widgets/alertcontent.dart';
import 'package:mkr/features/clients/clientmoves/presentation/view/widgets/clientaction.dart';
import 'package:mkr/features/clients/clientmoves/presentation/view/widgets/clientmovepdf.dart';
import 'package:mkr/features/clients/clientmoves/presentation/view/widgets/movedesc.dart';
import 'package:mkr/features/clients/clientmoves/presentation/viewmodel/cubit/clientmoves_cubit.dart';
import 'package:share_plus/share_plus.dart';

class clientmoves extends StatefulWidget {
  ScrollController nscrollController = ScrollController();
  final int clientid;
  final String clientname;

  clientmoves({
    super.key,
    required this.clientid,
    required this.clientname,
  });

  @override
  State<clientmoves> createState() => _clientmovesState();
}

class _clientmovesState extends State<clientmoves> {
  final clientmoveheader = [
    "التاريخ",
    "النوع",
    "المبلغ",
    "تحديد",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<ClientmovesCubit>(context).datefrom = null;
    BlocProvider.of<ClientmovesCubit>(context).dateto = null;
    BlocProvider.of<ClientmovesCubit>(context).firstloading = false;
    await BlocProvider.of<ClientmovesCubit>(context)
        .getclientmoves(clienid: widget.clientid);
    widget.nscrollController.addListener(() async {
      if (widget.nscrollController.position.pixels ==
          widget.nscrollController.position.maxScrollExtent) {
        await BlocProvider.of<ClientmovesCubit>(context)
            .getamoreclients(clientid: widget.clientid);
      }
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
                    onPressed: () {
                      BlocProvider.of<ClientmovesCubit>(context).datefrom =
                          null;
                      BlocProvider.of<ClientmovesCubit>(context).dateto = null;
                      BlocProvider.of<ClientmovesCubit>(context)
                          .getclientmoves(clienid: widget.clientid);
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
                              content: clientmovesearch(
                                clientid: widget.clientid,
                              ),
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
              title: Text(
                "حركات العميل  ${widget.clientname}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: LayoutBuilder(builder: (context, constrains) {
              return Column(children: [
                Container(
                  height: 50,
                  color: appcolors.maincolor.withOpacity(0.7),
                  child: Row(
                      children: clientmoveheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex: e == "حذف" || e == "تحديد" || e == "النوع"
                                    ? 2
                                    : 3,
                              ))
                          .toList()),
                ),
                Expanded(child: BlocBuilder<ClientmovesCubit, ClientmovesState>(
                    builder: (context, state) {
                  if (state is getclientmoveloading) return loadingshimmer();
                  if (state is getclientmovefailure)
                    return errorfailure(
                      errormessage: state.errormessage,
                    );
                  else {
                    if (BlocProvider.of<ClientmovesCubit>(context)
                        .datamoves
                        .isEmpty) return nodata();

                    return ListView.separated(
                        controller: widget.nscrollController,
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<ClientmovesCubit>(context)
                                    .datamoves
                                    .length
                            ? loading()
                            : InkWell(
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
                                            content: clientmoveitem(
                                              clientmove: BlocProvider.of<
                                                      ClientmovesCubit>(context)
                                                  .datamoves[i],
                                            ));
                                      });
                                },
                                child: customtableclientmoveitem(
                                  check: Checkbox(
                                      value: BlocProvider.of<ClientmovesCubit>(
                                              context)
                                          .checks[i],
                                      onChanged: (val) {
                                        BlocProvider.of<ClientmovesCubit>(
                                                context)
                                            .changecheckbox(val!, i);
                                      }),
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  date:
                                      "${BlocProvider.of<ClientmovesCubit>(context).datamoves[i].date!}",
                                  price: BlocProvider.of<ClientmovesCubit>(context).datamoves[i].status != 1
                                      ? (BlocProvider.of<ClientmovesCubit>(context)
                                                  .datamoves[i]
                                                  .unitsPerPackaging! *
                                              double.parse(
                                                  BlocProvider.of<ClientmovesCubit>(context)
                                                      .datamoves[i]
                                                      .qty
                                                      .toString()) *
                                              ((100 -
                                                      double.parse(
                                                          BlocProvider.of<ClientmovesCubit>(context)
                                                              .datamoves[i]
                                                              .discountPercentage!)) /
                                                  100) *
                                              double.parse(
                                                  BlocProvider.of<ClientmovesCubit>(context)
                                                      .datamoves[i]
                                                      .price!))
                                          .toStringAsFixed(1)
                                      : BlocProvider.of<ClientmovesCubit>(context)
                                          .datamoves[i]
                                          .price!,
                                  status:
                                      BlocProvider.of<ClientmovesCubit>(context)
                                                  .datamoves[i]
                                                  .status ==
                                              0
                                          ? "عمليه"
                                          : BlocProvider.of<ClientmovesCubit>(
                                                          context)
                                                      .datamoves[i]
                                                      .status ==
                                                  1
                                              ? "دفع مبلغ"
                                              : "مرتجع",
                                  delte: IconButton(
                                      onPressed: () {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('deleteclientmove')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  ClientmovesCubit,
                                                  ClientmovesState>(
                                                listener:
                                                    (context, state) async {
                                                  if (state
                                                      is deleteclientmovesuccess) {
                                                    await BlocProvider.of<
                                                                ClientCubit>(
                                                            context)
                                                        .getclients();
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        context: context,
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes);
                                                  }
                                                  if (state
                                                      is deleteclientmovefailure) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        context: context,
                                                        message:
                                                            state.errormessage,
                                                        toaststate:
                                                            Toaststate.error);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is deleteclientmoveloading)
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
                                                                      ClientmovesCubit>(
                                                                  context)
                                                              .deleteclientmove(
                                                                  moveid: BlocProvider.of<
                                                                              ClientmovesCubit>(
                                                                          context)
                                                                      .datamoves[
                                                                          i]
                                                                      .id!);
                                                        },
                                                        child: const Text(
                                                          "تاكيد",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                  );
                                                },
                                              ),
                                              tittle: "هل تريد حذف الحركه");
                                        }
                                      },
                                      icon: Icon(
                                        color: Colors.red,
                                        deleteicon,
                                      )),
                                ),
                              ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount:
                            BlocProvider.of<ClientmovesCubit>(context)
                                        .loading ==
                                    true
                                ? BlocProvider.of<ClientmovesCubit>(context)
                                        .datamoves
                                        .length +
                                    1
                                : BlocProvider.of<ClientmovesCubit>(context)
                                    .datamoves
                                    .length);
                  }
                })),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () async {
                          if (!cashhelper
                              .getdata(key: "permessions")
                              .contains('clientsmovepdf')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else {
                            List<datummoves> clientfatora = [];
                            double totalprocess = 0;
                            double totalpay = 0;
                            for (int i = 0;
                                i <
                                    BlocProvider.of<ClientmovesCubit>(context)
                                        .checks
                                        .length;
                                i++) {
                              if (BlocProvider.of<ClientmovesCubit>(context)
                                      .checks[i] ==
                                  true) {
                                if (BlocProvider.of<ClientmovesCubit>(context)
                                        .datamoves[i]
                                        .status !=
                                    1) {
                                  totalprocess = totalprocess +
                                      (BlocProvider.of<ClientmovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .qty! *
                                          BlocProvider.of<ClientmovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .unitsPerPackaging! *
                                          double.parse(
                                              BlocProvider.of<ClientmovesCubit>(
                                                      context)
                                                  .datamoves[i]
                                                  .price!) *
                                          ((100 -
                                                  double.parse(BlocProvider.of<
                                                              ClientmovesCubit>(
                                                          context)
                                                      .datamoves[i]
                                                      .discountPercentage
                                                      .toString())) /
                                              100));
                                }
                                if (BlocProvider.of<ClientmovesCubit>(context)
                                        .datamoves[i]
                                        .status ==
                                    1) {
                                  totalpay = totalpay +
                                      double.parse(
                                          BlocProvider.of<ClientmovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .price!);
                                }
                                clientfatora.add(
                                    BlocProvider.of<ClientmovesCubit>(context)
                                        .datamoves[i]);
                              }
                            }
                            final img = await rootBundle
                                .load('assets/images/logo.jpeg');
                            final imageBytes = img.buffer.asUint8List();
                            File file = await Clientmovepdf.generatepdf(
                              clientname: widget.clientname,
                              categories: clientfatora,
                              maden: totalprocess >= totalpay
                                  ? (totalprocess - totalpay).toStringAsFixed(1)
                                  : "0",
                              daen: totalpay >= totalprocess
                                  ? (totalpay - totalprocess).toStringAsFixed(1)
                                  : "0",
                              imageBytes: imageBytes,
                            );
                            Clientmovepdf.openfile(file);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () async {
                          if (!cashhelper
                              .getdata(key: "permessions")
                              .contains('clientsmovepdf')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else {
                            List<datummoves> clientfatora = [];
                            double totalprocess = 0;
                            double totalpay = 0;
                            for (int i = 0;
                                i <
                                    BlocProvider.of<ClientmovesCubit>(context)
                                        .checks
                                        .length;
                                i++) {
                              if (BlocProvider.of<ClientmovesCubit>(context)
                                      .checks[i] ==
                                  true) {
                                if (BlocProvider.of<ClientmovesCubit>(context)
                                        .datamoves[i]
                                        .status !=
                                    1) {
                                  totalprocess = totalprocess +
                                      (BlocProvider.of<ClientmovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .qty! *
                                          BlocProvider.of<ClientmovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .unitsPerPackaging! *
                                          double.parse(
                                              BlocProvider.of<ClientmovesCubit>(
                                                      context)
                                                  .datamoves[i]
                                                  .price!) *
                                          ((100 -
                                                  double.parse(BlocProvider.of<
                                                              ClientmovesCubit>(
                                                          context)
                                                      .datamoves[i]
                                                      .discountPercentage
                                                      .toString())) /
                                              100));
                                }
                                if (BlocProvider.of<ClientmovesCubit>(context)
                                        .datamoves[i]
                                        .status ==
                                    1) {
                                  totalpay = totalpay +
                                      double.parse(
                                          BlocProvider.of<ClientmovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .price!);
                                }
                                clientfatora.add(
                                    BlocProvider.of<ClientmovesCubit>(context)
                                        .datamoves[i]);
                              }
                            }
                            final img = await rootBundle
                                .load('assets/images/logo.jpeg');
                            final imageBytes = img.buffer.asUint8List();
                            File file = await Clientmovepdf.generatepdf(
                              clientname: widget.clientname,
                              categories: clientfatora,
                              maden: totalprocess >= totalpay
                                  ? (totalprocess - totalpay).toStringAsFixed(1)
                                  : "0",
                              daen: totalpay >= totalprocess
                                  ? (totalpay - totalprocess).toStringAsFixed(1)
                                  : "0",
                              imageBytes: imageBytes,
                            );

                            Share.shareXFiles([XFile(file.path)]);
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () {
                          if (!cashhelper
                              .getdata(key: "permessions")
                              .contains('addclientmove')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(
                                context: context,
                                page: addclientmove(
                                    clientid: widget.clientid,
                                    clientname: widget.clientname));
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })));
  }
}
