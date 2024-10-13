import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class InputFieldGreen extends StatefulWidget {
  final String hintText;
  final String prefixIcon;
  final Widget? suffixIcon;
  final bool isObscure;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  const InputFieldGreen(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.isObscure = false,
      this.validator,
      this.textInputType});

  @override
  State<InputFieldGreen> createState() => _InputFieldGreenState();
}

class _InputFieldGreenState extends State<InputFieldGreen> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // onTapOutside: (value) {
      //   FocusManager.instance.primaryFocus?.unfocus();
      // },
      validator: widget.validator,
      // ?? (String? value) {
      //   if (value!.isEmpty) {
      //     return 'Enter value';
      //   }
      //   return null;
      // },
      keyboardType: widget.textInputType,
      obscureText: (widget.isObscure && obscureText == true) ? true : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIconConstraints: BoxConstraints(maxHeight: 30.h),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SvgPicture.asset(widget.prefixIcon),
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
      ),
    );
  }
}
