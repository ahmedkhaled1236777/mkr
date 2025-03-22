import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';

class pickedimage extends StatefulWidget {
  ImagePicker picker = ImagePicker();

  @override
  State<pickedimage> createState() => _pickedimageState();
}

class _pickedimageState extends State<pickedimage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5)),
      child: MaterialButton(
        padding: const EdgeInsets.all(21),
        onPressed: () {
          BlocProvider.of<fullprodCubit>(context).uploadimage();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.image,
              size: 19,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'اختيار الصور',
              style: TextStyle(fontSize: 12.5),
            ),
          ],
        ),
      ),
    );
  }
}
