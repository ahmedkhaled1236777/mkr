import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:mkr/core/common/widgets/loading.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:mkr/core/common/widgets/showdialogerror.dart';
import 'package:mkr/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:mkr/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:mkr/features/users/presentation/viewmodel/showemployeecuibt/employeestates.dart';
import 'package:mkr/features/users/presentation/views/widgets/customtableemployeeitem.dart';
import 'package:mkr/features/users/presentation/views/widgets/editemployeedialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class customtableemployees extends StatefulWidget {
  ScrollController scrollController = ScrollController();
  final double width;
  customtableemployees(this.width);

  @override
  State<customtableemployees> createState() => _customtableemployeeesState();
}

class _customtableemployeeesState extends State<customtableemployees> {
  initscroll() async {
    BlocProvider.of<showemployeescuibt>(context).employeesdata.clear();
    await BlocProvider.of<showemployeescuibt>(context).getallemployees();
  }

  @override
  void initState() {
    initscroll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 50,
            color: appcolors.maincolor.withOpacity(0.7),
            child: Row(
                children: BlocProvider.of<AddemployeeCubit>(context)
                    .headertable
                    .map((e) => customheadertable(
                        title: e,
                        flex:
                            e == "تعديل" || e == "الحاله" || e == "حذف" ? 2 : 3,
                        textStyle: Styles.getheadertextstyle(context: context)))
                    .toList()),
          ),
          Expanded(
              child: BlocConsumer<showemployeescuibt, showemployeesstates>(
                  listener: (context, state) {
            if (state is showemployeesfailure)
              showtoast(
                  message: state.error_message,
                  context: context,
                  toaststate: Toaststate.error);
            if (state is deleteemployeefailure)
              showtoast(
                  message: state.errormessage,
                  context: context,
                  toaststate: Toaststate.succes);
          }, builder: (context, state) {
            if (state is showemployeesloading) return loadingshimmer();
            if (state is showemployeesfailure) return SizedBox();
            return BlocProvider.of<showemployeescuibt>(context)
                    .employeesdata
                    .isEmpty
                ? nodata()
                : SingleChildScrollView(
                    controller: widget.scrollController,
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: customtableemployeeitem(
                                delete: IconButton(
                                    onPressed: () {
                                      if (BlocProvider.of<showemployeescuibt>(
                                                  context)
                                              .employeesdata[index]
                                              .roleId ==
                                          1) {
                                        showdialogerror(
                                            error: "الادمن ممنوع المسح",
                                            context: context);
                                      } else {
                                        if (!cashhelper
                                            .getdata(key: "permessions")
                                            .contains('deleteusers')) {
                                          showdialogerror(
                                              error: "ليس لديك الصلاحيه",
                                              context: context);
                                        } else {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  showemployeescuibt,
                                                  showemployeesstates>(
                                                listener: (context, state) {
                                                  if (state
                                                      is deleteemployeesuccess) {
                                                    BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .getallemployees();
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message: state
                                                            .succes_message,
                                                        toaststate:
                                                            Toaststate.succes,
                                                        context: context);
                                                  }
                                                  if (state
                                                      is deleteemployeefailure) {
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
                                                      is deleteemployeeloading)
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
                                                                      showemployeescuibt>(
                                                                  context)
                                                              .deleteemployee(
                                                                  employeenumber: BlocProvider.of<
                                                                              showemployeescuibt>(
                                                                          context)
                                                                      .employeesdata[
                                                                          index]
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
                                              tittle:
                                                  "هل تريد حذف  ${BlocProvider.of<showemployeescuibt>(context).employeesdata[index].name}");
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      deleteicon,
                                      color: Colors.red,
                                    )),
                                status:
                                    BlocProvider.of<showemployeescuibt>(context)
                                                .employeesdata[index]
                                                .isActive ==
                                            1
                                        ? "مفعل"
                                        : "غير مفعل",
                                textStyle:
                                    Styles.gettabletextstyle(context: context),
                                employeename:
                                    BlocProvider.of<showemployeescuibt>(context)
                                            .employeesdata[index]
                                            .name ??
                                        "",
                                phone:
                                    BlocProvider.of<showemployeescuibt>(context)
                                            .employeesdata[index]
                                            .phone ??
                                        "",
                                job:
                                    BlocProvider.of<showemployeescuibt>(context)
                                            .employeesdata[index]
                                            .jobTitle ??
                                        "",
                                edit: IconButton(
                                  icon: const Icon(
                                    Icons.edit_note,
                                    size: 29,
                                  ),
                                  onPressed: () {
                                    if (BlocProvider.of<showemployeescuibt>(
                                                context)
                                            .employeesdata[index]
                                            .roleId ==
                                        1) {
                                      showdialogerror(
                                          error: "الادمن ممنوع التعديل",
                                          context: context);
                                    } else {
                                      if (!cashhelper
                                          .getdata(key: "permessions")
                                          .contains('editusers')) {
                                        showdialogerror(
                                            error: "ليس لديك الصلاحيه",
                                            context: context);
                                      } else {
                                        BlocProvider.of<AddemployeeCubit>(
                                                    context)
                                                .is_active =
                                            BlocProvider.of<showemployeescuibt>(
                                                    context)
                                                .employeesdata[index]
                                                .isActive
                                                .toString();
                                        BlocProvider.of<AddemployeeCubit>(
                                                    context)
                                                .manager =
                                            BlocProvider.of<showemployeescuibt>(
                                                    context)
                                                .employeesdata[index]
                                                .roleId
                                                .toString();
                                        BlocProvider.of<AddemployeeCubit>(
                                                    context)
                                                .selecteditems =
                                            BlocProvider.of<showemployeescuibt>(
                                                    context)
                                                .employeesdata[index]
                                                .permissions!;
                                        //صلاحيات الموظف مش راجعه مع المستخدمين
                                        showDialog(
                                            barrierDismissible: false,
                                            // user must tap button!
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                  title: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      AddemployeeCubit>(
                                                                  context)
                                                              .resetdata();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: const Icon(
                                                            Icons.close)),
                                                  ),
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  content: editemployeedialog(
                                                    isactive: BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .employeesdata[index]
                                                        .isActive
                                                        .toString(),
                                                    userid: BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .employeesdata[index]
                                                        .id
                                                        .toString(),
                                                    width:
                                                        MediaQuery.sizeOf(
                                                                        context)
                                                                    .width >
                                                                950
                                                            ? MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.25
                                                            : MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.85,
                                                    role: BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .employeesdata[index]
                                                        .roleId
                                                        .toString(),
                                                    employeename:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<showemployeescuibt>(
                                                                        context)
                                                                .employeesdata[
                                                                    index]
                                                                .name
                                                                .toString()),
                                                    email: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    showemployeescuibt>(
                                                                context)
                                                            .employeesdata[
                                                                index]
                                                            .email
                                                            .toString()),
                                                    phone: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    showemployeescuibt>(
                                                                context)
                                                            .employeesdata[
                                                                index]
                                                            .phone
                                                            .toString()),
                                                    jobtittle:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<showemployeescuibt>(
                                                                        context)
                                                                .employeesdata[
                                                                    index]
                                                                .jobTitle
                                                                .toString()),
                                                  ));
                                            });
                                      }
                                    }
                                  },
                                )),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: BlocProvider.of<showemployeescuibt>(context)
                            .employeesdata
                            .length),
                  );
          }))
        ]));
  }
}
