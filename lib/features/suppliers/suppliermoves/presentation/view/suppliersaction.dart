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
import 'package:mkr/features/suppliers/supplier/presentation/viewmodel/supplier/supplier_cubit.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermovemodel/datum.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/view/addaction.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/view/widgets/alertcontent.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/view/widgets/supplieraction.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/view/widgets/movedesc.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/view/widgets/suppliermovepdf.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/viewmodel/supplier/suppliermoves_cubit.dart';
import 'package:share_plus/share_plus.dart';

class suppliermoves extends StatefulWidget {
  ScrollController nscrollController = ScrollController();
  final int supplierid;
  final String suppliername;

  suppliermoves({
    super.key,
    required this.supplierid,
    required this.suppliername,
  });

  @override
  State<suppliermoves> createState() => _suppliermovesState();
}

class _suppliermovesState extends State<suppliermoves> {
  final suppliermoveheader = [
    "التاريخ",
    "النوع",
    "المبلغ",
    "تحديد",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<suppliermovesCubit>(context).datefrom = null;
    BlocProvider.of<suppliermovesCubit>(context).dateto = null;
    BlocProvider.of<suppliermovesCubit>(context).firstloading = false;
    await BlocProvider.of<suppliermovesCubit>(context)
        .getsuppliermoves(supplierid: widget.supplierid);
    widget.nscrollController.addListener(() async {
      if (widget.nscrollController.position.pixels ==
          widget.nscrollController.position.maxScrollExtent) {
        await BlocProvider.of<suppliermovesCubit>(context)
            .getamoresuppliers(supplierid: widget.supplierid);
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
                    onPressed: () async {
                      BlocProvider.of<suppliermovesCubit>(context).datefrom =
                          null;
                      BlocProvider.of<suppliermovesCubit>(context).dateto =
                          null;
                      await BlocProvider.of<suppliermovesCubit>(context)
                          .getsuppliermoves(supplierid: widget.supplierid);
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
                              content: suppliermovesearch(
                                supplierid: widget.supplierid,
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
                "حركات المورد  ${widget.suppliername}",
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
                      children: suppliermoveheader
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
                Expanded(child:
                    BlocBuilder<suppliermovesCubit, suppliermovesState>(
                        builder: (context, state) {
                  if (state is getsuppliermoveloading) return loadingshimmer();
                  if (state is getsuppliermovefailure)
                    return errorfailure(
                      errormessage: state.errormessage,
                    );
                  else {
                    if (BlocProvider.of<suppliermovesCubit>(context)
                        .datamoves
                        .isEmpty) return nodata();

                    return ListView.separated(
                        controller: widget.nscrollController,
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<suppliermovesCubit>(context)
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
                                            content: suppliermoveitem(
                                              suppliermove: BlocProvider.of<
                                                          suppliermovesCubit>(
                                                      context)
                                                  .datamoves[i],
                                            ));
                                      });
                                },
                                child: customtablesuppliermoveitem(
                                  check: Checkbox(
                                      value:
                                          BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .checks[i],
                                      onChanged: (val) {
                                        BlocProvider.of<suppliermovesCubit>(
                                                context)
                                            .changecheckbox(val!, i);
                                      }),
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  date:
                                      "${BlocProvider.of<suppliermovesCubit>(context).datamoves[i].date!}",
                                  price: BlocProvider.of<suppliermovesCubit>(context)
                                              .datamoves[i]
                                              .status ==
                                          0
                                      ? (BlocProvider.of<suppliermovesCubit>(context)
                                                  .datamoves[i]
                                                  .unitsPerPackaging! *
                                              double.parse(BlocProvider.of<
                                                          suppliermovesCubit>(
                                                      context)
                                                  .datamoves[i]
                                                  .qty
                                                  .toString()) *
                                              double.parse(
                                                  BlocProvider.of<suppliermovesCubit>(
                                                          context)
                                                      .datamoves[i]
                                                      .price!))
                                          .toStringAsFixed(1)
                                      : BlocProvider.of<suppliermovesCubit>(context)
                                          .datamoves[i]
                                          .price!,
                                  status: BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .status ==
                                          0
                                      ? "توريد"
                                      : "دفع مبلغ",
                                  delte: IconButton(
                                      onPressed: () {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('showsuppliermove')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  suppliermovesCubit,
                                                  suppliermovesState>(
                                                listener:
                                                    (context, state) async {
                                                  if (state
                                                      is deletesuppliermovesuccess) {
                                                    await BlocProvider.of<
                                                                supplierCubit>(
                                                            context)
                                                        .getsuppliers();
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        context: context,
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes);
                                                  }
                                                  if (state
                                                      is deletesuppliermovefailure) {
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
                                                      is deletesuppliermoveloading)
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
                                                                      suppliermovesCubit>(
                                                                  context)
                                                              .deletesuppliermove(
                                                                  moveid: BlocProvider.of<
                                                                              suppliermovesCubit>(
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
                            BlocProvider.of<suppliermovesCubit>(context)
                                        .loading ==
                                    true
                                ? BlocProvider.of<suppliermovesCubit>(context)
                                        .datamoves
                                        .length +
                                    1
                                : BlocProvider.of<suppliermovesCubit>(context)
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
                              .contains('suppliermovepdf')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else {
                            List<datummoves> supplierfatora = [];
                            double totalprocess = 0;
                            double totalpay = 0;
                            for (int i = 0;
                                i <
                                    BlocProvider.of<suppliermovesCubit>(context)
                                        .checks
                                        .length;
                                i++) {
                              if (BlocProvider.of<suppliermovesCubit>(context)
                                      .checks[i] ==
                                  true) {
                                if (BlocProvider.of<suppliermovesCubit>(context)
                                        .datamoves[i]
                                        .status ==
                                    0) {
                                  totalprocess = totalprocess +
                                      (BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .qty! *
                                          BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .unitsPerPackaging! *
                                          double.parse(BlocProvider.of<
                                                  suppliermovesCubit>(context)
                                              .datamoves[i]
                                              .price!));
                                }
                                if (BlocProvider.of<suppliermovesCubit>(context)
                                        .datamoves[i]
                                        .status ==
                                    1) {
                                  totalpay = totalpay +
                                      double.parse(
                                          BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .price!);
                                }
                                supplierfatora.add(
                                    BlocProvider.of<suppliermovesCubit>(context)
                                        .datamoves[i]);
                              }
                            }
                            final img = await rootBundle
                                .load('assets/images/logo.jpeg');
                            final imageBytes = img.buffer.asUint8List();
                            File file = await Suppliermovepdf.generatepdf(
                              clientname: widget.suppliername,
                              categories: supplierfatora,
                              daen: totalprocess >= totalpay
                                  ? (totalprocess - totalpay).toStringAsFixed(1)
                                  : "0",
                              maden: totalpay >= totalprocess
                                  ? (totalpay - totalprocess).toStringAsFixed(1)
                                  : "0",
                              imageBytes: imageBytes,
                            );
                            Suppliermovepdf.openfile(file);
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
                              .contains('suppliermovepdf')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else {
                            List<datummoves> supplierfatora = [];
                            double totalprocess = 0;
                            double totalpay = 0;
                            for (int i = 0;
                                i <
                                    BlocProvider.of<suppliermovesCubit>(context)
                                        .checks
                                        .length;
                                i++) {
                              if (BlocProvider.of<suppliermovesCubit>(context)
                                      .checks[i] ==
                                  true) {
                                if (BlocProvider.of<suppliermovesCubit>(context)
                                        .datamoves[i]
                                        .status ==
                                    0) {
                                  totalprocess = totalprocess +
                                      (BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .qty! *
                                          BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .unitsPerPackaging! *
                                          double.parse(BlocProvider.of<
                                                  suppliermovesCubit>(context)
                                              .datamoves[i]
                                              .price!));
                                }
                                if (BlocProvider.of<suppliermovesCubit>(context)
                                        .datamoves[i]
                                        .status ==
                                    1) {
                                  totalpay = totalpay +
                                      double.parse(
                                          BlocProvider.of<suppliermovesCubit>(
                                                  context)
                                              .datamoves[i]
                                              .price!);
                                }
                                supplierfatora.add(
                                    BlocProvider.of<suppliermovesCubit>(context)
                                        .datamoves[i]);
                              }
                            }
                            final img = await rootBundle
                                .load('assets/images/logo.jpeg');
                            final imageBytes = img.buffer.asUint8List();
                            File file = await Suppliermovepdf.generatepdf(
                              clientname: widget.suppliername,
                              categories: supplierfatora,
                              daen: totalprocess >= totalpay
                                  ? (totalprocess - totalpay).toStringAsFixed(1)
                                  : "0",
                              maden: totalpay >= totalprocess
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
                              .contains('addsuppliermove')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(
                                context: context,
                                page: addsuppliermove(
                                    supplierid: widget.supplierid,
                                    suppliername: widget.suppliername));
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
