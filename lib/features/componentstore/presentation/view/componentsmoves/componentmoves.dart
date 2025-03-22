import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:mkr/core/common/widgets/loading.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:mkr/core/common/widgets/showdialogerror.dart';
import 'package:mkr/features/componentstore/presentation/view/componentsmoves/addmove.dart';
import 'package:mkr/features/componentstore/presentation/view/componentsmoves/widgets/componentmoveitem.dart';
import 'package:mkr/features/componentstore/presentation/view/componentsmoves/widgets/customtablecomponentmoveitem.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';

class Componentmoves extends StatefulWidget {
  ScrollController nscrollController = ScrollController();
  final int componentid;
  final String componentname;
  final String packtype;

  Componentmoves(
      {super.key,
      required this.componentid,
      required this.componentname,
      required this.packtype});

  @override
  State<Componentmoves> createState() => _ComponentmovesState();
}

class _ComponentmovesState extends State<Componentmoves> {
  final componentheader = [
    "التاريخ",
    "الكميه",
    "النوع",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<ComponentCubit>(context).firstloadingmotion = false;
    BlocProvider.of<ComponentCubit>(context)
        .getcomponentmotion(compid: widget.componentid);
    widget.nscrollController.addListener(() async {
      if (widget.nscrollController.position.pixels ==
          widget.nscrollController.position.maxScrollExtent) {
        await BlocProvider.of<ComponentCubit>(context)
            .getmorecomponentssmotion(componentid: widget.componentid);
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
                      BlocProvider.of<ComponentCubit>(context)
                          .getcomponentmotion(compid: widget.componentid);
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      /*showDialog(
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
                              content: Dateaccessoriesearch(
                                accessorieid: widget.accessorieid,
                              ),
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
              title: Text(
                "حركات  ${widget.componentname}",
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
                      children: componentheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex: e == "حذف" || e == "تعديل" ? 2 : 3,
                              ))
                          .toList()),
                ),
                Expanded(child: BlocBuilder<ComponentCubit, ComponentState>(
                    builder: (context, state) {
                  if (state is getcomponentmoveloading) return loadingshimmer();
                  if (state is getcomponentmovefailure)
                    return errorfailure(
                      errormessage: state.errormessage,
                    );
                  else {
                    if (BlocProvider.of<ComponentCubit>(context)
                        .datamoves
                        .isEmpty) return nodata();

                    return ListView.separated(
                        controller: widget.nscrollController,
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<ComponentCubit>(context)
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
                                            content: Componentmoveitem(
                                                componentitem: BlocProvider.of<
                                                        ComponentCubit>(context)
                                                    .datamoves[i]));
                                      });
                                },
                                child: Customtablecomponentmoveitem(
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  date:
                                      "${BlocProvider.of<ComponentCubit>(context).datamoves[i].date!.day}-${BlocProvider.of<ComponentCubit>(context).datamoves[i].date!.month}-${BlocProvider.of<ComponentCubit>(context).datamoves[i].date!.year}",
                                  qty: BlocProvider.of<ComponentCubit>(context)
                                      .datamoves[i]
                                      .qty!
                                      .toString(),
                                  status:
                                      BlocProvider.of<ComponentCubit>(context)
                                                  .datamoves[i]
                                                  .status ==
                                              true
                                          ? "اضافه"
                                          : "سحب",
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                ComponentCubit, ComponentState>(
                                              listener: (context, state) async {
                                                if (state
                                                    is deletecomponentmovesuccess) {
                                                  await BlocProvider.of<
                                                              ComponentCubit>(
                                                          context)
                                                      .getcomponents();
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      context: context,
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes);
                                                }
                                                if (state
                                                    is deletecomponentmovefailure) {
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
                                                    is deletecomponentmoveloading)
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
                                                                    ComponentCubit>(
                                                                context)
                                                            .deletecomponentmove(
                                                                componentmoveid:
                                                                    BlocProvider.of<ComponentCubit>(
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
                        itemCount: BlocProvider.of<ComponentCubit>(context)
                                    .motionloading ==
                                true
                            ? BlocProvider.of<ComponentCubit>(context)
                                    .datamoves
                                    .length +
                                1
                            : BlocProvider.of<ComponentCubit>(context)
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
                        onTap: () {},
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
                        onTap: () async {},
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
                          navigateto(
                              context: context,
                              page: Addcomponentmove(
                                packtype: widget.packtype,
                                prodname: widget.componentname,
                                prodid: widget.componentid,
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
