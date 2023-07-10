import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatelessWidget {
  final FontWeight fontWeight;
  final String text;
  final int? maxLines;
  final Color color;
  final double fontSize;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const AppText.semiBold(
    this.text, {
    super.key,
    this.decoration,
    this.textAlign,
    this.fontSize = 16,
    this.maxLines,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w600,
  });

  const AppText.regular(
    this.text, {
    super.key,
    this.decoration,
    this.fontSize = 16,
    this.maxLines,
    this.textAlign,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w400,
  });

  const AppText.bold(
    this.text, {
    super.key,
    this.decoration,
    this.fontSize = 16,
    this.textAlign,
    this.maxLines,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        decoration: decoration,
        fontSize: fontSize.spMin,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
