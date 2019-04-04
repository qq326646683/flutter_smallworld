import 'dart:ui' as ui show Shadow;
import 'package:flutter/material.dart';

class SMTextStyle extends TextStyle {
  /*
  * 添加默认行高0.8 * fontSize
  * 默认fontWeight = FontWeight.w300
  * */
  const SMTextStyle({
    bool inherit = true,
    Color color,
    double fontSize,
    FontWeight fontWeight = FontWeight.w300,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height = 0.8,
    Locale locale,
    Paint foreground,
    Paint background,
    List<ui.Shadow> shadows,
    TextDecoration decoration = TextDecoration.none,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    String debugLabel,
    String fontFamily,
    String package,
  }) : super(
      inherit: inherit,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      debugLabel: debugLabel,
      fontFamily: fontFamily,
      package: package
  );

}