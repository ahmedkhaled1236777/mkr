import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';

// ignore: camel_case_types
class customgridimages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<fullprodCubit, fullprodState>(builder: (context, state) {
      return Container(
        height: 100,
        width: 100,
        child: Stack(children: [
          Image.file(
            File(BlocProvider.of<fullprodCubit>(context).image!.path),
            fit: BoxFit.cover,
          ),
          IconButton(
              onPressed: () {
                BlocProvider.of<fullprodCubit>(context).resetimage();
              },
              icon: Icon(Icons.cancel))
        ]),
      );
    });
  }
}
