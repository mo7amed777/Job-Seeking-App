import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilledIconButton extends StatelessWidget {
  final Widget? icon;
  final Color? color;
  final Color? iconColor;
  final String svgIcon;
  final VoidCallback onTap;
  final OutlinedBorder? shape;
  const FilledIconButton(
      {super.key,
      this.icon,
      required this.svgIcon,
      required this.onTap,
      this.shape,
      this.color,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onTap,
      style: IconButton.styleFrom(
        shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: color ?? Colors.white.withOpacity(0.1),
      ),
      icon: icon ?? SvgPicture.asset(svgIcon, color: iconColor),
    );
  }
}
