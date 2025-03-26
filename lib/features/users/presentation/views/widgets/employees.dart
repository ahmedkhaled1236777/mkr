import 'package:mkr/features/users/presentation/views/widgets/dektopemployees.dart';
import 'package:flutter/material.dart';

class users extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return usersState();
  }
}

class usersState extends State<users> {
  GlobalKey<ScaffoldState> scafoldstate = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate1 = DateTime.now();
  var date1 = 'التاريخ';
  var date2 = 'اضغط لاختيار تاريخ محدد';

  @override
  Widget build(BuildContext context) {
    return desktopemployees();
  }
}
