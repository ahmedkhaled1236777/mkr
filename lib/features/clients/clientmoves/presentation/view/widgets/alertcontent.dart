import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/features/clients/clientmoves/presentation/viewmodel/cubit/clientmoves_cubit.dart';

class clientmovesearch extends StatelessWidget {
  final int clientid;

  const clientmovesearch({super.key, required this.clientid});
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
                                      BlocProvider.of<DateCubit>(context).date3,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate3(context);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date4,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate4(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            custommaterialbutton(
                              button_name: "بحث",
                              onPressed: () async {
                                if ((BlocProvider.of<DateCubit>(context)
                                                .date3 ==
                                            "التاريخ من" &&
                                        BlocProvider.of<DateCubit>(context)
                                                .date4 !=
                                            "التاريخ الي") ||
                                    (BlocProvider.of<DateCubit>(context)
                                                .date3 !=
                                            "التاريخ من" &&
                                        BlocProvider.of<DateCubit>(context)
                                                .date4 ==
                                            "التاريخ الي")) {
                                  showdialogerror(
                                      error:
                                          "برجاء تحديد التاريخ من والتاريخ الي",
                                      context: context);
                                } else {
                                  BlocProvider.of<ClientmovesCubit>(context)
                                          .datefrom =
                                      BlocProvider.of<DateCubit>(context)
                                                  .date3 ==
                                              "التاريخ من"
                                          ? null
                                          : BlocProvider.of<DateCubit>(context)
                                              .date3;
                                  BlocProvider.of<ClientmovesCubit>(context)
                                          .dateto =
                                      BlocProvider.of<DateCubit>(context)
                                                  .date4 ==
                                              "التاريخ الي"
                                          ? null
                                          : BlocProvider.of<DateCubit>(context)
                                              .date4;
                                  await BlocProvider.of<ClientmovesCubit>(
                                          context)
                                      .getclientmoves(
                                    clienid: clientid,
                                  );
                                  Navigator.pop(context);
                                }
                              },
                            )
                          ]))))
            ])));
  }
}

Future<void> _onPressed({
  required BuildContext context,
  String? locale,
}) async {}
