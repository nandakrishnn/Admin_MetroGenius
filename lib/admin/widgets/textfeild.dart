import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/colors.dart';

// ignore: must_be_immutable
class CustomTextFeild extends StatelessWidget {
  CustomTextFeild(
      {required this.hinttext,
      this.sufixbutton,
      this.suffix,
      this.prefixIcon,
      this.controller,
      super.key,
      this.onChanged,
     required this.obscure,
      this.validator});
  String hinttext;
  Widget? suffix;
  bool obscure;
  Icon? sufixbutton;
  Icon? prefixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
   void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscure,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
          ),
          // focusColor: Colors.grey,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
          ),
          border: OutlineInputBorder(
              gapPadding: 4,
              borderSide: const BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
              borderRadius: BorderRadius.circular(10)),
          hintText: hinttext,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 174, 169, 169)),
          filled: true,
          fillColor: AppColors.primaryColor,
          suffixIcon: sufixbutton,
          prefixIcon: prefixIcon),
    );
  }
}
