import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InputFieldGreenNew extends StatefulWidget {
  final String hintText;
  final String prefixIcon;
  final Widget? suffixIcon;
  final bool isObscure;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? serverErrorMessage;

  const InputFieldGreenNew({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.isObscure = false,
    this.textInputType,
    this.serverErrorMessage,
  });

  @override
  State<InputFieldGreenNew> createState() => _InputFieldGreenState();
}

class _InputFieldGreenState extends State<InputFieldGreenNew> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.isObscure ? obscureText : false,
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
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined))
            : widget.suffixIcon,
        errorText: widget.serverErrorMessage,
      ),
    );
  }
}
