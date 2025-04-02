import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployessPowers extends StatefulWidget {
  const EmployessPowers({super.key});

  @override
  State<EmployessPowers> createState() => EmployessPowersState();
}

class EmployessPowersState extends State<EmployessPowers> {
  final List<String> items = [
    "client",
    "addclient",
    "editclient",
    "deleteclient",
    "clientspdf",
    "clientsmovepdf",
    "addclientmove",
    "showclientmove",
    "deleteclientmove",
    "supplier",
    "addsupplier",
    "editsupplier",
    "deletesupplier",
    "addsuppliermove",
    "deletesuppliermove",
    "showsuppliermove",
    "suppliermovepdf",
    "addcomponent",
    "component",
    "deletecomponent",
    "editcomponent",
    "addcomponentmove",
    "showcomponentmove",
    "deletecomponentmove",
    "componentmovepdf",
    "componentpdf",
    "fullprod",
    "addfullprod",
    "deletefullprod",
    "editfullprod",
    "addfullprodmove",
    "showfullprodmove",
    "deletefullprodmove",
    "fullprodpdf",
    "fullprodmovepdf",
    "users",
    "editusers",
    "addusers",
    "deleteusers",
    "workers",
    "editworker",
    "deleteworker",
    "addworker",
    "attendance",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddemployeeCubit, AddemployeeState>(
        builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'الصلاحيات',
                style: TextStyle(
                  fontSize: 12.5,
                  fontFamily: "cairo",
                  color: appcolors.maincolor,
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected =
                          BlocProvider.of<AddemployeeCubit>(context)
                              .selecteditems
                              .contains(item);
                      return InkWell(
                        onTap: () {
                          isSelected
                              ? {
                                  BlocProvider.of<AddemployeeCubit>(context)
                                      .selecteditems
                                      .remove(item)
                                }
                              : BlocProvider.of<AddemployeeCubit>(context)
                                  .selecteditems
                                  .add(item);
                          //This rebuilds the StatefulWidget to update the button's text
                          setState(() {});
                          //This rebuilds the dropdownMenu Widget to update the check mark
                          menuSetState(() {});
                        },
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_box_outlined)
                              else
                                const Icon(Icons.check_box_outline_blank),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
              value: BlocProvider.of<AddemployeeCubit>(context)
                      .selecteditems
                      .isEmpty
                  ? null
                  : BlocProvider.of<AddemployeeCubit>(context)
                      .selecteditems
                      .last,
              onChanged: (value) {},
              selectedItemBuilder: (context) {
                return items.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          BlocProvider.of<AddemployeeCubit>(context)
                              .selecteditems
                              .join(' - '),
                          style: const TextStyle(
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(left: 0, right: 0),
                height: 35,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      );
    });
  }
}
