import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';

class Alertcontent extends StatefulWidget {
  final int supplierid;

  const Alertcontent({super.key, required this.supplierid});
  @override
  State<Alertcontent> createState() => _AlertcontentcontentState();
}

class _AlertcontentcontentState extends State<Alertcontent> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('بحث بواسطة',
                                style: Styles.textStyle12
                                    .copyWith(color: appcolors.maincolor),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
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
                            const SizedBox(
                              height: 15,
                            ),
                            custommaterialbutton(
                              button_name: "بحث",
                              onPressed: () {},
                            )
                          ]))))
            ])));
  }
}

Future<void> _onPressed({
  required BuildContext context,
  String? locale,
}) async {}
