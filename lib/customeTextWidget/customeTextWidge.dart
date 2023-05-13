import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeTextWidget extends StatelessWidget {
  final String? textString;
  final Key? key;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? wordSpacing;
  final double? textHeight;
  final double? letterSpacing;

  CustomeTextWidget(
      {this.textString,
      this.key,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.overflow,
      this.softWrap,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.textSize,
      this.fontWeight,
      this.textColor,
      this.wordSpacing,
      this.textHeight,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(textString!,
        style: GoogleFonts.lato(
            color: textColor!, fontSize: textSize!, fontWeight: fontWeight!));
  }
}
