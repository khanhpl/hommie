import 'package:flutter/material.dart';
import 'package:hommie/core/app_export.dart';

class AppStyle {
  static TextStyle txtInterRegular12 = TextStyle(
    color: ColorConstant.gray400,
    fontSize: getFontSize(
      12,
    ),
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterSemiBold12 = TextStyle(
    color: ColorConstant.green400,
    fontSize: getFontSize(
      12,
    ),
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );

  static TextStyle txtRobotoRomanBold36 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      36,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtRobotoRomanMedium14 = TextStyle(
    color: ColorConstant.primaryColor,
    fontSize: getFontSize(
      14,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtRobotoRomanRegular13 = TextStyle(
    color: ColorConstant.gray600,
    fontSize: getFontSize(
      13,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );
}
