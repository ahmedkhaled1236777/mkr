import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/fullprodstore/data/models/fullprodmodelrequest.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';

class editfullproddialog extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController fullprodname = TextEditingController();
  TextEditingController packtype = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController qtyinpack = TextEditingController();
  TextEditingController alarm = TextEditingController();
  final int id;
  final String quantity;

  editfullproddialog(
      {super.key,
      required this.fullprodname,
      required this.quantity,
      required this.packtype,
      required this.price,
      required this.qtyinpack,
      required this.alarm,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            custommytextform(
              controller: fullprodname,
              hintText: "اسم المنتج",
              val: "برجاء ادخال اسم المنتج",
            ),
            const SizedBox(
              height: 10,
            ),
            custommytextform(
              controller: price,
              hintText: "سعر القطعه",
              val: "برجاء ادخال سعر القطعه",
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<fullprodCubit, fullprodState>(
              builder: (context, state) {
                return Column(
                  children: [
                    custommytextform(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
                      ],
                      keyboardType: TextInputType.number,
                      controller: qtyinpack,
                      hintText: packtype.text.isEmpty
                          ? "العدد داخل النوع"
                          : "العدد داخل ${packtype.text}",
                      val: "برجاء ادخال العدد داخل النوع",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    custommytextform(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
                      ],
                      keyboardType: TextInputType.number,
                      controller: alarm,
                      hintText: packtype.text.isEmpty
                          ? "كمية التحذير"
                          : "كمية التحذير ب${packtype.text}",
                      val: "برجاء ادخال كمية التحذير",
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            BlocConsumer<fullprodCubit, fullprodState>(
              listener: (context, state) {
                if (state is editfullprodfailure) {
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
                }
                if (state is editfullprodsuccess) {
                  Navigator.pop(context);
                  BlocProvider.of<fullprodCubit>(context).getfullprods();
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes,
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is editfullprodloading) return loading();
                return custommaterialbutton(
                  button_name: "تسجيل مكون",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<fullprodCubit>(context).editfullprod(
                          id: id,
                          fullprod: fullprodmodelrequest(
                              fullprodname: fullprodname.text,
                              price: price.text,
                              quantity: quantity,
                              alarmqty: alarm.text,
                              packtype: packtype.text,
                              qtyinpack: qtyinpack.text));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
