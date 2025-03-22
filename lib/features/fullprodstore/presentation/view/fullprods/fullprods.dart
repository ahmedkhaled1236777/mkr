import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprodmoves/widgets/pdf/pdf.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:mkr/core/common/widgets/loading.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:mkr/core/common/widgets/showdialogerror.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprodmoves/fullprodmove.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprods/addfullprod.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprods/widgets/customtablefullproditem.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprods/widgets/editdialod.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprods/widgets/fullproditem.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';
import 'package:share_plus/share_plus.dart';

class fullprod extends StatefulWidget {
  @override
  State<fullprod> createState() => _fullprodState();
}

class _fullprodState extends State<fullprod> {
  final fullprodheader = [
    "اسم المكون",
    "سعر القطعه",
    "الكميه",
    "نوع التعبئه",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<fullprodCubit>(context).getfullprods();
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
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    heroTag: "1",
                    backgroundColor: appcolors.primarycolor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      navigateto(context: context, page: addfullprod());
                    }),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                    heroTag: "0",
                    backgroundColor: appcolors.primarycolor,
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final img =
                          await rootBundle.load('assets/images/logo.jpeg');
                      final imageBytes = img.buffer.asUint8List();
                      File file = await storagepdf.generatepdf(
                          imageBytes: imageBytes,
                          categories: BlocProvider.of<fullprodCubit>(context)
                              .fullprods);
                      await storagepdf.openfile(file);
                    }),
              ],
            ),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      /*     showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Container(
                                height: 20,
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
                              content: Alertmoldcontent(),
                            );
                          });*/
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "مخزن المنتج التام",
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
                    children: fullprodheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "تعديل" ||
                                      e == "حذف" ||
                                      e == "نوع التعبئه"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<fullprodCubit, fullprodState>(
                      listener: (context, state) {
                if (state is getfullprodfailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
              }, builder: (context, state) {
                if (state is getfullprodloading) return loadingshimmer();
                if (state is getfullprodfailure)
                  return errorfailure(
                    errormessage: state.errormessage,
                  );
                else {
                  if (BlocProvider.of<fullprodCubit>(context).fullprods.isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onDoubleTap: () {
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
                                          content: fullproditems(
                                              fullproditem: BlocProvider.of<
                                                      fullprodCubit>(context)
                                                  .fullprods[i]));
                                    });
                              },
                              onTap: () {
                                navigateto(
                                    context: context,
                                    page: fullprodmoves(
                                        qtyintype:
                                            BlocProvider.of<fullprodCubit>(
                                                    context)
                                                .fullprods[i]
                                                .unitsPerPackaging!
                                                .toString(),
                                        fullprodid:
                                            BlocProvider.of<fullprodCubit>(
                                                    context)
                                                .fullprods[i]
                                                .id!,
                                        fullprodname:
                                            BlocProvider.of<fullprodCubit>(
                                                    context)
                                                .fullprods[i]
                                                .name!,
                                        packtype:
                                            BlocProvider.of<fullprodCubit>(
                                                    context)
                                                .fullprods[i]
                                                .packagingType!));
                              },
                              child: Customtablefullproditem(
                                  pieceprice: BlocProvider.of<fullprodCubit>(context)
                                      .fullprods[i]
                                      .priceUnit!
                                      .toString(),
                                  alarm: BlocProvider.of<fullprodCubit>(context)
                                      .fullprods[i]
                                      .warningQty!
                                      .toString(),
                                  color: BlocProvider.of<fullprodCubit>(context)
                                              .fullprods[i]
                                              .warningQty! >=
                                          BlocProvider.of<fullprodCubit>(context)
                                              .fullprods[i]
                                              .qty!
                                      ? Colors.red
                                      : Colors.white,
                                  fullprodname:
                                      BlocProvider.of<fullprodCubit>(context)
                                          .fullprods[i]
                                          .name!,
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  edit: IconButton(
                                      color: BlocProvider.of<fullprodCubit>(context)
                                                  .fullprods[i]
                                                  .warningQty! >=
                                              BlocProvider.of<fullprodCubit>(context)
                                                  .fullprods[i]
                                                  .qty!
                                          ? Colors.white
                                          : const Color.fromARGB(255, 9, 62, 88),
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Container(
                                                  height: 20,
                                                  alignment: Alignment.topLeft,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color:
                                                            appcolors.maincolor,
                                                      )),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                backgroundColor: Colors.white,
                                                insetPadding:
                                                    EdgeInsets.all(35),
                                                content: editfullproddialog(
                                                    fullprodname: TextEditingController(
                                                        text: BlocProvider.of<fullprodCubit>(context)
                                                            .fullprods[i]
                                                            .name),
                                                    price: TextEditingController(
                                                        text: BlocProvider.of<fullprodCubit>(context)
                                                            .fullprods[i]
                                                            .priceUnit),
                                                    quantity:
                                                        BlocProvider.of<fullprodCubit>(context)
                                                            .fullprods[i]
                                                            .qty!
                                                            .toString(),
                                                    packtype: TextEditingController(
                                                        text: BlocProvider.of<fullprodCubit>(context)
                                                            .fullprods[i]
                                                            .packagingType),
                                                    qtyinpack: TextEditingController(
                                                        text: BlocProvider.of<fullprodCubit>(context)
                                                            .fullprods[i]
                                                            .unitsPerPackaging
                                                            .toString()),
                                                    alarm: TextEditingController(
                                                        text: BlocProvider.of<fullprodCubit>(context)
                                                            .fullprods[i]
                                                            .warningQty
                                                            .toString()),
                                                    id: BlocProvider.of<fullprodCubit>(context).fullprods[i].id!),
                                              );
                                            });
                                      },
                                      icon: Icon(editeicon)),
                                  quantity: BlocProvider.of<fullprodCubit>(context).fullprods[i].qty!.toString(),
                                  packtype: BlocProvider.of<fullprodCubit>(context).fullprods[i].packagingType ?? "",
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                fullprodCubit, fullprodState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deletefullprodsuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes,
                                                      context: context);
                                                }
                                                if (state
                                                    is deletefullprodfailure) {
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
                                                    is deletefullprodloading)
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
                                                                    42)),
                                                      ),
                                                      onPressed: () async {
                                                        await BlocProvider.of<
                                                                    fullprodCubit>(
                                                                context)
                                                            .deletefullprod(
                                                                fullprodid: BlocProvider.of<
                                                                            fullprodCubit>(
                                                                        context)
                                                                    .fullprods[
                                                                        i]
                                                                    .id!);
                                                      },
                                                      child: const Text(
                                                        "تاكيد",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: "cairo",
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                );
                                              },
                                            ),
                                            tittle: "هل تريد الحذف ؟");
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: BlocProvider.of<fullprodCubit>(
                                                        context)
                                                    .fullprods[i]
                                                    .warningQty! >=
                                                BlocProvider.of<fullprodCubit>(
                                                        context)
                                                    .fullprods[i]
                                                    .qty!
                                            ? Colors.white
                                            : Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<fullprodCubit>(context)
                            .fullprods
                            .length);
                  }
                }
              })),
            ])));
  }
}
