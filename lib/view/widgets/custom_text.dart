import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
        required this.text,
        this.fontSize = 14,
        this.color = Colors.black,
        this.alignment = Alignment.topLeft,
        this.fontWeight = FontWeight.normal, this.padding})
      : super(key: key);

  final String text;

  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Alignment alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: alignment,
      child: Text(
        text,
        style: GoogleFonts.lateef(fontSize: fontSize, color: color,letterSpacing: 2,fontWeight: fontWeight,),
      ),
    );
  }
}
