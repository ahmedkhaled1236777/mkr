import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/navigation.dart';
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
import 'package:mkr/features/componentstore/presentation/view/components/addcomponent.dart';
import 'package:mkr/features/componentstore/presentation/view/components/widgets/componentitem.dart';
import 'package:mkr/features/componentstore/presentation/view/components/widgets/customtabletimeritem.dart';
import 'package:mkr/features/componentstore/presentation/view/components/widgets/editdialod.dart';
import 'package:mkr/features/componentstore/presentation/view/componentsmoves/componentmoves.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';

class component extends StatefulWidget {
  @override
  State<component> createState() => _componentState();
}

class _componentState extends State<component> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final componentheader = [
    "اسم المكون",
    "الكميه",
    "نوع التعبئه",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<ComponentCubit>(context).getcomponents();
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: appcolors.primarycolor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  navigateto(context: context, page: addcomponent());
                }),
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
                "مخزن المكونات",
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
                    children: componentheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<ComponentCubit, ComponentState>(
                      listener: (context, state) {
                if (state is getcomponentfailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
              }, builder: (context, state) {
                if (state is getcomponentloading) return loadingshimmer();
                if (state is getcomponentfailure)
                  return errorfailure(
                    errormessage: state.errormessage,
                  );
                else {
                  if (BlocProvider.of<ComponentCubit>(context)
                      .components
                      .isEmpty)
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
                                          content: Componentitem(
                                              componentitem: BlocProvider.of<
                                                      ComponentCubit>(context)
                                                  .components[i]));
                                    });
                              },
                              onTap: () {
                                navigateto(
                                    context: context,
                                    page: Componentmoves(
                                        componentid:
                                            BlocProvider.of<ComponentCubit>(
                                                    context)
                                                .components[i]
                                                .id!,
                                        componentname:
                                            BlocProvider.of<ComponentCubit>(
                                                    context)
                                                .components[i]
                                                .name!,
                                        packtype:
                                            BlocProvider.of<ComponentCubit>(
                                                    context)
                                                .components[i]
                                                .packagingType!));
                              },
                              child: Customtablecomponentitem(
                                  alarm:
                                      BlocProvider.of<ComponentCubit>(context)
                                          .components[i]
                                          .warningQty!
                                          .toString(),
                                  color: BlocProvider.of<ComponentCubit>(context)
                                              .components[i]
                                              .warningQty! >=
                                          BlocProvider.of<ComponentCubit>(context)
                                              .components[i]
                                              .qty!
                                      ? Colors.red
                                      : Colors.white,
                                  componentname:
                                      BlocProvider.of<ComponentCubit>(context)
                                          .components[i]
                                          .name!,
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  edit: IconButton(
                                      color: BlocProvider.of<ComponentCubit>(context)
                                                  .components[i]
                                                  .warningQty! >=
                                              BlocProvider.of<ComponentCubit>(context)
                                                  .components[i]
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
                                                content: editcomponentdialog(
                                                    componentname:
                                                        TextEditingController(
                                                            text: BlocProvider.of<ComponentCubit>(context)
                                                                .components[i]
                                                                .name),
                                                    quantity:
                                                        BlocProvider.of<ComponentCubit>(context)
                                                            .components[i]
                                                            .qty!
                                                            .toString(),
                                                    packtype: TextEditingController(
                                                        text: BlocProvider.of<ComponentCubit>(context)
                                                            .components[i]
                                                            .packagingType),
                                                    qtyinpack: TextEditingController(
                                                        text: BlocProvider.of<ComponentCubit>(context)
                                                            .components[i]
                                                            .unitsPerPackaging
                                                            .toString()),
                                                    alarm: TextEditingController(
                                                        text:
                                                            BlocProvider.of<ComponentCubit>(context)
                                                                .components[i]
                                                                .warningQty
                                                                .toString()),
                                                    id: BlocProvider.of<ComponentCubit>(context)
                                                        .components[i]
                                                        .id!),
                                              );
                                            });
                                      },
                                      icon: Icon(editeicon)),
                                  quantity: BlocProvider.of<ComponentCubit>(context).components[i].qty!.toString(),
                                  packtype: BlocProvider.of<ComponentCubit>(context).components[i].packagingType ?? "",
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                ComponentCubit, ComponentState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deletecomponentsuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes,
                                                      context: context);
                                                }
                                                if (state
                                                    is deletecomponentfailure) {
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
                                                    is deletecomponentloading)
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
                                                            .deletecomponent(
                                                                componentid: BlocProvider.of<
                                                                            ComponentCubit>(
                                                                        context)
                                                                    .components[
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
                                        color: BlocProvider.of<ComponentCubit>(
                                                        context)
                                                    .components[i]
                                                    .warningQty! >=
                                                BlocProvider.of<ComponentCubit>(
                                                        context)
                                                    .components[i]
                                                    .qty!
                                            ? Colors.white
                                            : Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<ComponentCubit>(context)
                            .components
                            .length);
                  }
                }
              })),
            ])));
  }
}
