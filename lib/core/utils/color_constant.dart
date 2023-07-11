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

  static Color black90026 = fromHex('#26000000');

  static Color yellow900 = fromHex('#fc6e20');

  static Color blueGray700 = fromHex('#4d4867');

  static Color blueGray7007f = fromHex('#7f4d4867');

  static Color lime100 = fromHex('#f5ecdf');
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
