import 'package:flutter/material.dart';
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
import 'package:mkr/features/fullprodstore/presentation/view/fullprodmoves/addmove.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprodmoves/widgets/alertfullprodearch.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprodmoves/widgets/customtablefullprodmoveitem.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprodmoves/widgets/fullprodmoveitem.dart';

import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';

class fullprodmoves extends StatefulWidget {
  ScrollController nscrollController = ScrollController();
  final int fullprodid;
  final String fullprodname;
  final String qtyintype;
  final String packtype;

  fullprodmoves(
      {super.key,
      required this.fullprodid,
      required this.fullprodname,
      required this.qtyintype,
      required this.packtype});

  @override
  State<fullprodmoves> createState() => _fullprodmovesState();
}

class _fullprodmovesState extends State<fullprodmoves> {
  final fullprodheader = [
    "التاريخ",
    "الكميه",
    "النوع",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<fullprodCubit>(context).datefrom = null;
    BlocProvider.of<fullprodCubit>(context).dateto = null;
    BlocProvider.of<fullprodCubit>(context).name_of_client = null;
    BlocProvider.of<fullprodCubit>(context).firstloadingmotion = false;
    BlocProvider.of<fullprodCubit>(context)
        .getfullprodmotion(compid: widget.fullprodid);
    widget.nscrollController.addListener(() async {
      if (widget.nscrollController.position.pixels ==
          widget.nscrollController.position.maxScrollExtent) {
        await BlocProvider.of<fullprodCubit>(context)
            .getmorefullprodssmotion(fullprodid: widget.fullprodid);
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
                      BlocProvider.of<fullprodCubit>(context).datefrom = null;
                      BlocProvider.of<fullprodCubit>(context).dateto = null;
                      BlocProvider.of<fullprodCubit>(context).name_of_client =
                          null;
                      await BlocProvider.of<fullprodCubit>(context)
                          .getfullprodmotion(compid: widget.fullprodid);
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
                              content: Alertfullprodmovessearch(
                                fullprodid: widget.fullprodid,
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
                "حركات  ${widget.fullprodname}",
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
                      children: fullprodheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex: e == "حذف" || e == "تعديل" ? 2 : 3,
                              ))
                          .toList()),
                ),
                Expanded(child: BlocBuilder<fullprodCubit, fullprodState>(
                    builder: (context, state) {
                  if (state is getfullprodmoveloading) return loadingshimmer();
                  if (state is getfullprodmovefailure)
                    return errorfailure(
                      errormessage: state.errormessage,
                    );
                  else {
                    if (BlocProvider.of<fullprodCubit>(context)
                        .datamoves
                        .isEmpty) return nodata();

                    return ListView.separated(
                        controller: widget.nscrollController,
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<fullprodCubit>(context)
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
                                            content: fullprodmoveitem(
                                                packtype: widget.packtype,
                                                qtyintype: widget.qtyintype,
                                                fullproditem: BlocProvider.of<
                                                        fullprodCubit>(context)
                                                    .datamoves[i]));
                                      });
                                },
                                child: Customtablefullprodmoveitem(
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  date:
                                      "${BlocProvider.of<fullprodCubit>(context).datamoves[i].date!}",
                                  qty: BlocProvider.of<fullprodCubit>(context)
                                      .datamoves[i]
                                      .qty!
                                      .toString(),
                                  status:
                                      BlocProvider.of<fullprodCubit>(context)
                                                  .datamoves[i]
                                                  .status ==
                                              true
                                          ? "اضافه"
                                          : "سحب",
                                  delete: IconButton(
                                      onPressed: () {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('deletefullprodmove')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          if (BlocProvider.of<fullprodCubit>(
                                                      context)
                                                  .datamoves[i]
                                                  .type ==
                                              1) {
                                            showdialogerror(
                                                error:
                                                    "يتم المسح من حركات العملاء",
                                                context: context);
                                          } else {
                                            awsomdialogerror(
                                                context: context,
                                                mywidget: BlocConsumer<
                                                    fullprodCubit,
                                                    fullprodState>(
                                                  listener:
                                                      (context, state) async {
                                                    if (state
                                                        is deletefullprodmovesuccess) {
                                                      await BlocProvider.of<
                                                                  fullprodCubit>(
                                                              context)
                                                          .getfullprods();
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,
                                                          message: state
                                                              .successmessage,
                                                          toaststate: Toaststate
                                                              .succes);
                                                    }
                                                    if (state
                                                        is deletefullprodmovefailure) {
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,
                                                          message: state
                                                              .errormessage,
                                                          toaststate:
                                                              Toaststate.error);
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    if (state
                                                        is deletefullprodmoveloading)
                                                      return deleteloading();
                                                    return SizedBox(
                                                      height: 50,
                                                      width: 100,
                                                      child: ElevatedButton(
                                                          style:
                                                              const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        37,
                                                                        163,
                                                                        42)),
                                                          ),
                                                          onPressed: () async {
                                                            await BlocProvider
                                                                    .of<fullprodCubit>(
                                                                        context)
                                                                .deletefullprodmove(
                                                                    fullprodmoveid: BlocProvider.of<fullprodCubit>(
                                                                            context)
                                                                        .datamoves[
                                                                            i]
                                                                        .id!);
                                                          },
                                                          child: const Text(
                                                            "تاكيد",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                    );
                                                  },
                                                ),
                                                tittle: "هل تريد حذف الحركه");
                                          }
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
                        itemCount: BlocProvider.of<fullprodCubit>(context)
                                    .motionloading ==
                                true
                            ? BlocProvider.of<fullprodCubit>(context)
                                    .datamoves
                                    .length +
                                1
                            : BlocProvider.of<fullprodCubit>(context)
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
                        onTap: () {
                          if (!cashhelper
                              .getdata(key: "permessions")
                              .contains('addfullprodmove')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(
                                context: context,
                                page: Addfullprodmove(
                                  packtype: widget.packtype,
                                  prodname: widget.fullprodname,
                                  prodid: widget.fullprodid,
                                ));
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
