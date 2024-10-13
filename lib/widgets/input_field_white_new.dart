import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eservices/utils/app_colors.dart';

class InputFieldWhiteNew extends StatefulWidget {
  final String hintText;
  final String? prefixIconSvg;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isObscure;
  final TextEditingController? controller;
  final String? serverErrorMessage;

  const InputFieldWhiteNew(
      {super.key,
      required this.hintText,
      this.prefixIconSvg,
      this.suffixIcon,
      this.controller,
      this.isObscure = false,
      this.serverErrorMessage,
      this.prefixIcon});

  @override
  State<InputFieldWhiteNew> createState() => _InputFieldWhiteNewState();
}

class _InputFieldWhiteNewState extends State<InputFieldWhiteNew> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // onTapOutside: (value) {
      //   FocusManager.instance.primaryFocus?.unfocus();
      // },
      obscureText: (widget.isObscure && obscureText == true) ? true : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: false,
        prefixIconConstraints: BoxConstraints(maxHeight: 30.h),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.2, color: colorLightGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SvgPicture.asset(widget.prefixIconSvg ?? ''),
        ),
        suffixIcon: widget.isObscure
            ? IconButton(
                onPressed: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                icon: Icon(obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined))
            : widget.suffixIcon,
        errorText: widget.serverErrorMessage,
      ),
    );
  }
}
