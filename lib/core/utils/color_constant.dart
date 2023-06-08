import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray600 = fromHex('#747070');

  static Color gray400 = fromHex('#aeaeae');

  static Color gray500 = fromHex('#a29696');

  static Color black900 = fromHex('#000000');

  static Color gray200 = fromHex('#eeeeee');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray50 = fromHex('#fafafa');

  static Color green400 = fromHex('#5cb85c');

  static Color primaryColor = fromHex('#e2994a');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
