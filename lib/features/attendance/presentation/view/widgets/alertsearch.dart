import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/features/clients/clieents/presentation/viewmodel/client/client_cubit.dart';

class Alertsearch extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              custommytextform(
                controller: name,
                hintText: "اسم العميل",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                keyboardType: TextInputType.number,
                controller: phone,
                hintText: "رقم الهاتف",
              ),
              SizedBox(
                height: 35,
              ),
              custommaterialbutton(
                  button_name: "بحث",
                  onPressed: () async {
                    // ignore: await_only_futures
                    BlocProvider.of<ClientCubit>(context).queryparma = {
                      if (phone.text.isNotEmpty) "phone": phone.text,
                      if (name.text.isNotEmpty) "name": name.text
                    };
                    await BlocProvider.of<ClientCubit>(context).getclients();
                    Navigator.pop(context);
                  }),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
