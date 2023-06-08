import 'package:flutter/material.dart';
import 'package:hommie/core/app_export.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: getPadding(
              left: 18,
              right: 18,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame,
                  height: getVerticalSize(
                    140,
                  ),
                  width: getHorizontalSize(
                    140,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 22,
                  ),
                  child: Text(
                    "Đăng nhập",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRobotoRomanBold36,
                  ),
                ),
                CustomTextFormField(
                  focusNode: FocusNode(),
                  controller: null,
                  hintText: "vanh@gmail.com",
                  margin: getMargin(
                    left: 6,
                    top: 47,
                    right: 2,
                  ),
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                  prefix: Container(
                    margin: getMargin(
                      left: 23,
                      top: 20,
                      right: 12,
                      bottom: 19,
                    ),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgCheckmark,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(
                    maxHeight: getVerticalSize(
                      54,
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        (!isValidEmail(value, isRequired: true))) {
                      return "Vui lòng nhập đúng định dạng email";
                    }
                    return null;
                  },
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgGroup12622,
                  height: getVerticalSize(
                    54,
                  ),
                  width: getHorizontalSize(
                    346,
                  ),
                  margin: getMargin(
                    top: 26,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 13,
                    right: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 3,
                          bottom: 3,
                        ),
                        child: Text(
                          "Quên mật khẩu",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRobotoRomanMedium14,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  height: getVerticalSize(
                    54,
                  ),
                  text: "Đăng nhập",
                  margin: getMargin(
                    left: 6,
                    top: 18,
                    right: 2,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 12,
                    top: 31,
                    right: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 7,
                          bottom: 7,
                        ),
                        child: SizedBox(
                          width: getHorizontalSize(
                            120,
                          ),
                          child: Divider(
                            height: getVerticalSize(
                              1,
                            ),
                            thickness: getVerticalSize(
                              1,
                            ),
                            color: ColorConstant.gray500,
                          ),
                        ),
                      ),
                      Text(
                        "Hoặc",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoRomanRegular13,
                      ),
                      Padding(
                        padding: getPadding(
                          top: 7,
                          bottom: 7,
                        ),
                        child: SizedBox(
                          width: getHorizontalSize(
                            120,
                          ),
                          child: Divider(
                            height: getVerticalSize(
                              1,
                            ),
                            thickness: getVerticalSize(
                              1,
                            ),
                            color: ColorConstant.gray500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  height: getVerticalSize(
                    54,
                  ),
                  text: "Đăng nhập với google",
                  margin: getMargin(
                    left: 6,
                    top: 29,
                    right: 2,
                  ),
                  variant: ButtonVariant.OutlineGray200,
                  shape: ButtonShape.RoundedBorder15,
                  padding: ButtonPadding.PaddingT18,
                  fontStyle: ButtonFontStyle.RobotoRomanMedium15Black900,
                  prefixWidget: Container(
                    margin: getMargin(
                      right: 9,
                    ),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgGoogleLogo,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 18,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: getPadding(
                          bottom: 1,
                        ),
                        child: Text(
                          "Chưa có tài khoản",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterRegular12,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 9,
                          top: 1,
                        ),
                        child: Text(
                          "Đăng ký",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterSemiBold12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
