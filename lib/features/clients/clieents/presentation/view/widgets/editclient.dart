import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/clients/clieents/data/models/clientrequest.dart';
import 'package:mkr/features/clients/clieents/presentation/viewmodel/client/client_cubit.dart';

class editclientdialog extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController clientname = TextEditingController();
  TextEditingController phone = TextEditingController();

  final int id;

  editclientdialog(
      {super.key,
      required this.clientname,
      required this.phone,
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
              controller: clientname,
              hintText: "اسم العميل",
              val: "برجاء ادخال اسم العميل",
            ),
            const SizedBox(
              height: 10,
            ),
            custommytextform(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
              ],
              keyboardType: TextInputType.number,
              controller: phone,
              hintText: "رقم هاتف العميل",
              val: "برجاء ادخال رقم هاتف العميل",
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
            BlocConsumer<ClientCubit, clientState>(
              listener: (context, state) {
                if (state is editclientfailure) {
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
                }
                if (state is editclientsuccess) {
                  Navigator.pop(context);
                  BlocProvider.of<ClientCubit>(context).getclients();
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes,
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is editclientloading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل البيانات",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<ClientCubit>(context).editcoponent(
                          id: id,
                          client: Clientrequest(
                            name: clientname.text,
                            phone: phone.text,
                          ));
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
