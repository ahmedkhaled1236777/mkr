import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprodmoves/widgets/fullprodradio.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';

import '../../../data/models/fullprodemoverequest.dart';

class Addfullprodmove extends StatefulWidget {
  final String packtype;
  final String prodname;
  final int prodid;

  Addfullprodmove(
      {super.key,
      required this.packtype,
      required this.prodname,
      required this.prodid});
  @override
  State<Addfullprodmove> createState() => _AddfullprodmoveState();
}

class _AddfullprodmoveState extends State<Addfullprodmove> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController qty = TextEditingController();
  TextEditingController nameofsupplier = TextEditingController();
  TextEditingController discount_percentage = TextEditingController();

  TextEditingController notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "اضافة حركة ${widget.prodname}",
                style: Styles.appbarstyle,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/home.png",
                      ))),
              child: Center(
                child: Form(
                    key: formkey,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      margin: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.sizeOf(context).width < 600 ? 0 : 15)),
                      width: MediaQuery.sizeOf(context).width > 650
                          ? MediaQuery.sizeOf(context).width * 0.4
                          : double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 9),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            const SizedBox(
                              height: 25,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date1,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<fullprodCubit, fullprodState>(
                              builder: (context, state) {
                                return fullprodsradio(
                                  firstradio: "0",
                                  secondradio: "1",
                                  firstradiotitle: "سحب",
                                  secondradiotitle: "اضافه",
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<fullprodCubit, fullprodState>(
                              builder: (context, state) {
                                return Column(children: [
                                  if (BlocProvider.of<fullprodCubit>(context)
                                          .materialstatus ==
                                      "0")
                                    custommytextform(
                                      controller: nameofsupplier,
                                      hintText: "اسم العميل",
                                      val: "برجاء ادخال اسم العميل",
                                    ),
                                ]);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9-.]")),
                              ],
                              keyboardType: TextInputType.number,
                              controller: qty,
                              hintText: "الكميه ب${widget.packtype}",
                              val: "برجاء ادخال الكميه",
                            ),
                            SizedBox(height: 10),
                            if (BlocProvider.of<fullprodCubit>(context)
                                    .materialstatus ==
                                "0")
                              custommytextform(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9-.]")),
                                ],
                                keyboardType: TextInputType.number,
                                controller: discount_percentage,
                                hintText: "نسبة الخصم %",
                                val: "برجاء ادخال نسبة الخصم",
                              ),
                            SizedBox(height: 10),
                            custommytextform(
                              controller: notes,
                              hintText: "الملاحظات",
                              val: "برجاء ادخال الملاحظات",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<fullprodCubit, fullprodState>(
                              listener: (context, state) async {
                                if (state is addfullprodmovefailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addfullprodmovesuccess) {
                                  qty.clear();
                                  nameofsupplier.clear();
                                  discount_percentage.clear();
                                  notes.clear();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<fullprodCubit>(context)
                                      .changematerialstatus("0");
                                  await BlocProvider.of<fullprodCubit>(context)
                                      .getfullprodmotion(compid: widget.prodid);
                                  BlocProvider.of<fullprodCubit>(context)
                                      .getfullprods();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addfullprodmoveloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate())
                                      BlocProvider.of<fullprodCubit>(context)
                                          .addfullprodmove(
                                              fullprod: fullprodmoverequest(
                                                  discount_percentage:
                                                      discount_percentage.text,
                                                  qty: qty.text,
                                                  name_of_client:
                                                      BlocProvider.of<fullprodCubit>(
                                                                      context)
                                                                  .materialstatus ==
                                                              "0"
                                                          ? nameofsupplier.text
                                                          : "لا يوجد",
                                                  warehouse_id: widget.prodid,
                                                  date: BlocProvider.of<DateCubit>(
                                                          context)
                                                      .date1,
                                                  status: BlocProvider.of<
                                                          fullprodCubit>(context)
                                                      .materialstatus,
                                                  notes: notes.text));
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ]))),
                    )),
              ),
            )));
  }
}
