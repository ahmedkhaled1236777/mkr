import 'dart:io';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/urls.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform%20copy%202.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/auth/login/presentation/viewmodel/cubit/auth_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:mkr/features/home/presentation/view/home2.dart';

class Updateprofile extends StatefulWidget {
  final TextEditingController name;

  final TextEditingController phone;

  final TextEditingController email;
  final TextEditingController oldpass = TextEditingController();
  final TextEditingController newpass = TextEditingController();
  final TextEditingController newpassconfirm = TextEditingController();

  Updateprofile(
      {super.key,
      required this.name,
      required this.phone,
      required this.email});
  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  File? photo;
  uploadimage() async {
    final ImagePicker picker = ImagePicker();

    var pikedimage = await picker.pickImage(source: ImageSource.gallery);
    if (pikedimage != null) {
      photo = File(pikedimage.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolors.maincolor,
          leading: BackButton(color: Colors.white),
        ),
        backgroundColor: appcolors.maincolor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width > 950
                    ? MediaQuery.sizeOf(context).width * 0.3
                    : MediaQuery.sizeOf(context).width > 650
                        ? MediaQuery.sizeOf(context).width * 0.2
                        : 20,
                vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 85,
                ),
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    photo == null
                        ? cashhelper.getdata(key: "image") == null
                            ? CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                radius: 45.0,
                                backgroundImage: AssetImage(
                                  'assets/images/master.jpg',
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(45),
                                child: CachedNetworkImage(
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.fill,
                                  imageUrl: cashhelper.getdata(key: "image"),
                                  errorWidget: (context, url, Widget) {
                                    return const Icon(
                                      Icons.person,
                                      color: Colors.red,
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return CircularProgressIndicator();
                                  },
                                ),
                              )
                        : CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 45.0,
                            backgroundImage: FileImage(
                              photo!,
                            ),
                          ),
                    IconButton(
                        onPressed: () {
                          uploadimage();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                customtextform(
                  controller: widget.name,
                  prefixicon: Icon(Icons.person),
                  hintText: "الاسم",
                  val: "برجاء ادخال الاسم",
                ),
                const SizedBox(
                  height: 10,
                ),
                customtextform(
                  keyboardType: TextInputType.number,
                  controller: widget.phone,
                  prefixicon: Icon(Icons.phone),
                  hintText: "رقم الهاتف",
                  val: "برجاء ادخال رقم الهاتف",
                ),
                const SizedBox(
                  height: 10,
                ),
                customtextform(
                  controller: widget.email,
                  prefixicon: Icon(Icons.email),
                  hintText: "البريد الالكتروني",
                  val: "برجاء ادخال البريد الالكتروني",
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        customtextform(
                          suffixIcon: IconButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .changeobsecure();
                              },
                              icon: Icon(
                                BlocProvider.of<AuthCubit>(context).obsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: appcolors.lighttext,
                              )),
                          obscureText:
                              BlocProvider.of<AuthCubit>(context).obsecure,
                          controller: widget.oldpass,
                          prefixicon: Icon(Icons.lock),
                          hintText: "كلمة المرور القديمه",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customtextform(
                          suffixIcon: IconButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .changeobsecure();
                              },
                              icon: Icon(
                                BlocProvider.of<AuthCubit>(context).obsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: appcolors.lighttext,
                              )),
                          obscureText:
                              BlocProvider.of<AuthCubit>(context).obsecure,
                          controller: widget.newpass,
                          prefixicon: Icon(Icons.lock),
                          hintText: "كلمة المرور الجديده",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customtextform(
                          suffixIcon: IconButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .changeobsecure();
                              },
                              icon: Icon(
                                BlocProvider.of<AuthCubit>(context).obsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: appcolors.lighttext,
                              )),
                          obscureText:
                              BlocProvider.of<AuthCubit>(context).obsecure,
                          controller: widget.newpassconfirm,
                          prefixicon: Icon(Icons.lock),
                          hintText: "تأكيد كلمة المرور الجديده",
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is updateprofilefailure) {
                      showtoast(
                          context: context,
                          message: state.errormessage,
                          toaststate: Toaststate.error);
                    }
                    if (state is updateprofilesuccess) {
                      if (state.success.data!.img != null) {
                        cashhelper.setdata(
                            key: "image",
                            value:
                                "${urls.imageurl}${state.success.data!.img}");
                      }
                      cashhelper.setdata(
                          key: "name", value: state.success.data!.name);
                      cashhelper.setdata(
                          key: "email", value: state.success.data!.email);
                      cashhelper.setdata(
                          key: "phone", value: state.success.data!.phone);
                      navigateandfinish(page: home2(), context: context);

                      showtoast(
                          context: context,
                          message: "تم تعديل البيانات بنجاح",
                          toaststate: Toaststate.succes);
                    }
                  },
                  builder: (context, state) {
                    if (state is updateprofileloading) return loading();
                    return custommaterialbutton(
                      button_name: "تعديل البيانات",
                      onPressed: () async {
                        if (widget.oldpass.text.isNotEmpty &&
                            widget.newpass.text != widget.newpassconfirm.text) {
                          showtoast(
                              message:
                                  "كلمه المرور الجديده والتاكيد ليست متشابهمين",
                              toaststate: Toaststate.error,
                              context: context);
                        } else
                          BlocProvider.of<AuthCubit>(context).updateprofile(
                              email: widget.email.text,
                              phone: widget.phone.text,
                              name: widget.name.text,
                              oldpass: widget.oldpass.text,
                              newpassconfirm: widget.newpassconfirm.text,
                              newpass: widget.newpass.text,
                              photo: photo);
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
