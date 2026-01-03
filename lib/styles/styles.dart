import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

EdgeInsets DefaultSideMargin({
    double topMargin = 0, 
    double bottomMargin = 0
  }){
  const double horizontalMargin = 30.0;
  final EdgeInsets margin =  EdgeInsets.only(left: horizontalMargin, right: horizontalMargin);
  if(topMargin != 0 || bottomMargin != 0){
    return EdgeInsets.only(left: horizontalMargin, right: horizontalMargin, top: topMargin, bottom: bottomMargin);
  }
  else{
    return margin;
  }
}

class CustomText extends StatelessWidget{
  final double fontSize;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontHeight;
  final String? font;
  final TextAlign textAlign;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.fontWeight, 
    required this.fontHeight,
    required this.textAlign,
    this.font
  });
  @override
  Widget build(BuildContext context) {
    TextStyle textStyles = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: fontHeight,
    );

    // apply GoogleFonts if requested by name
    if (font == 'gabarito') {
      textStyles = GoogleFonts.gabarito(textStyle: textStyles);
    }
    return Text(
      text,
      style: textStyles,
      textAlign: textAlign,
    );
  }
}

class PrimaryGabarito extends CustomText{
  const PrimaryGabarito({
    super.key,
    required super.text,
    required super.color,
    required super.textAlign,
  }) : super(
    font: 'gabarito',
    fontSize: 50,
    fontWeight: FontWeight.bold,
    fontHeight: 1.0
  );
}

class RegularGabarito extends CustomText{
  const RegularGabarito({
    super.key,
    required super.text,
    required super.color,
    required super.textAlign,
  }) : super(
    font: 'gabarito',
    fontSize: 20,
    fontWeight: FontWeight.normal,
    fontHeight: 1.2,
  );
}

class RegularButtonGabarito extends CustomText{
  const RegularButtonGabarito({
    super.key,
    required super.text,
    required super.color,
    required super.textAlign,
  }) : super(
    font: 'gabarito',
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontHeight: 1.2,
  );
}

class MediumGabarito extends CustomText{
  const MediumGabarito({
    super.key,
    required super.text,
    required super.color,
    required super.textAlign,
  }) : super(
    font: 'gabarito',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontHeight: 1,
  );
}

class SmallGabarito extends CustomText{
  const SmallGabarito({
    super.key,
    required super.text,
    required super.color,
    required super.textAlign,
  }) : super(
    font: 'gabarito',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontHeight: 1,
  );
}