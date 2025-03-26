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
import 'package:mkr/features/suppliers/supplier/presentation/view/clieents/addsupplier.dart';
import 'package:mkr/features/suppliers/supplier/presentation/view/clieents/widgets/alertsuppliersearch.dart';
import 'package:mkr/features/suppliers/supplier/presentation/view/clieents/widgets/customsupplieritem.dart';
import 'package:mkr/features/suppliers/supplier/presentation/view/clieents/widgets/editsupplier.dart';
import 'package:mkr/features/suppliers/supplier/presentation/view/clieents/widgets/supplierpdf.dart';
import 'package:mkr/features/suppliers/supplier/presentation/viewmodel/supplier/supplier_cubit.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/view/suppliersaction.dart';

class supplier extends StatefulWidget {
  @override
  State<supplier> createState() => _supplierState();
}

class _supplierState extends State<supplier> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final supplierheader = [
    "اسم المورد",
    "رقم الهاتف",
    "مدين",
    "دائن",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<supplierCubit>(context).queryparma = null;

    await BlocProvider.of<supplierCubit>(context).getsuppliers();
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
                      BlocProvider.of<supplierCubit>(context).queryparma = null;
                      await BlocProvider.of<supplierCubit>(context)
                          .getsuppliers();
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
                              content: Alertsuppliersearch(),
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
                "الموردين",
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
                    children: supplierheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<supplierCubit, supplierState>(
                      listener: (context, state) {
                if (state is getsupplierfailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
              }, builder: (context, state) {
                if (state is getsupplierloading) return loadingshimmer();
                if (state is getsupplierfailure)
                  return errorfailure(
                    errormessage: state.errormessage,
                  );
                else {
                  if (BlocProvider.of<supplierCubit>(context).suppliers.isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onDoubleTap: () {},
                              onTap: () {
                                if (!cashhelper
                                    .getdata(key: "permessions")
                                    .contains('showsuppliermove')) {
                                  showdialogerror(
                                      error: "ليس لديك الصلاحيه",
                                      context: context);
                                } else
                                  navigateto(
                                      context: context,
                                      page: suppliermoves(
                                        supplierid:
                                            BlocProvider.of<supplierCubit>(
                                                    context)
                                                .suppliers[i]
                                                .id!,
                                        suppliername:
                                            BlocProvider.of<supplierCubit>(
                                                    context)
                                                .suppliers[i]
                                                .name!,
                                      ));
                              },
                              child: Customsupplieritem(
                                  maden: BlocProvider.of<supplierCubit>(context).suppliers[i].totalPaid! >
                                          BlocProvider.of<supplierCubit>(context)
                                              .suppliers[i]
                                              .totalProcess!
                                      ? (BlocProvider.of<supplierCubit>(context).suppliers[i].totalPaid! -
                                              BlocProvider.of<supplierCubit>(context)
                                                  .suppliers[i]
                                                  .totalProcess!)
                                          .toStringAsFixed(1)
                                      : "0",
                                  daen: BlocProvider.of<supplierCubit>(context).suppliers[i].totalProcess! >
                                          BlocProvider.of<supplierCubit>(context)
                                              .suppliers[i]
                                              .totalPaid!
                                      ? (BlocProvider.of<supplierCubit>(context)
                                                  .suppliers[i]
                                                  .totalProcess! -
                                              BlocProvider.of<supplierCubit>(context).suppliers[i].totalPaid!)
                                          .toStringAsFixed(1)
                                      : "0",
                                  supplierphone: BlocProvider.of<supplierCubit>(context).suppliers[i].phone!,
                                  suppliername: BlocProvider.of<supplierCubit>(context).suppliers[i].name!,
                                  textStyle: Styles.gettabletextstyle(context: context),
                                  edit: IconButton(
                                      color: const Color.fromARGB(255, 9, 62, 88),
                                      onPressed: () {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('editsupplier')) {
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
                                                  content: editsupplierdialog(
                                                      suppliername:
                                                          TextEditingController(
                                                              text: BlocProvider
                                                                      .of<supplierCubit>(
                                                                          context)
                                                                  .suppliers[i]
                                                                  .name),
                                                      phone: TextEditingController(
                                                          text: BlocProvider.of<
                                                                      supplierCubit>(
                                                                  context)
                                                              .suppliers[i]
                                                              .phone),
                                                      id: BlocProvider.of<
                                                                  supplierCubit>(
                                                              context)
                                                          .suppliers[i]
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
                                            .contains('deletesupplier')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  supplierCubit, supplierState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is deletesuppliersuccess) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes,
                                                        context: context);
                                                  }
                                                  if (state
                                                      is deletesupplierfailure) {
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
                                                      is deletesupplierloading)
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
                                                                      supplierCubit>(
                                                                  context)
                                                              .deletesupplier(
                                                                  supplierid: BlocProvider.of<
                                                                              supplierCubit>(
                                                                          context)
                                                                      .suppliers[
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
                        itemCount: BlocProvider.of<supplierCubit>(context)
                            .suppliers
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
                              .contains('supplierspdf')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else {
                            double totalpay = 0;
                            double totalprocess = 0;
                            for (int i = 0;
                                i <
                                    BlocProvider.of<supplierCubit>(context)
                                        .suppliers
                                        .length;
                                i++) {
                              totalprocess = totalprocess +
                                  double.parse(
                                      BlocProvider.of<supplierCubit>(context)
                                          .suppliers[i]
                                          .totalProcess!
                                          .toString());
                              totalpay = totalpay +
                                  double.parse(
                                      BlocProvider.of<supplierCubit>(context)
                                          .suppliers[i]
                                          .totalPaid!
                                          .toString());
                            }
                            final img = await rootBundle
                                .load('assets/images/logo.jpeg');
                            final imageBytes = img.buffer.asUint8List();
                            File file = await Supplierpdf.generatepdf(
                              categories:
                                  BlocProvider.of<supplierCubit>(context)
                                      .suppliers,
                              maden: totalprocess >= totalpay
                                  ? (totalprocess - totalpay).toStringAsFixed(1)
                                  : "0",
                              daen: totalpay >= totalprocess
                                  ? (totalpay - totalprocess).toStringAsFixed(1)
                                  : "0",
                              imageBytes: imageBytes,
                            );
                            Supplierpdf.openfile(file);
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
                              .contains('addsupplier')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(context: context, page: addsupplier());
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
              ),
            ])));
  }
}
