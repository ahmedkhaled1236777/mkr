import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:mkr/features/users/presentation/views/widgets/addemployeewithscafold.dart';
import 'package:mkr/features/users/presentation/views/widgets/customtableemployees.dart';
import 'package:mkr/features/users/presentation/views/widgets/emplyeesearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class desktopemployees extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: appcolors.maincolor,
          floatingActionButton: FloatingActionButton(
              backgroundColor: appcolors.primarycolor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                navigateto(context: context, page: addemployeewithscafold());
              }),
          appBar: AppBar(
            leading: BackButton(
              color: Colors.white,
            ),
            title: Text(
              'المستخدمين',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: appcolors.maincolor,
            actions: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<showemployeescuibt>(context)
                        .employeesdata
                        .clear();
                    BlocProvider.of<showemployeescuibt>(context)
                        .getallemployees();
                  },
                  icon: Icon(Icons.refresh, color: Colors.white)),
              Row(
                children: [
                  emplyeesearch(),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
          body: customtableemployees((MediaQuery.of(context).size.width))),
    );
  }
}
