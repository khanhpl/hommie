
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_event.dart';
import '../../core/fire_base/provider/google_sign_in_provider.dart';
import '../sign_up_screen/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _signInBloc = SignInBloc();
  bool _showPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      resizeToAvoidBottomInset: false,
      body: Material(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: StreamBuilder<Object>(
            stream: _signInBloc.stateController.stream,
            builder: (context, snapshot) {
              return Container(
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
                      hintText: "Tài khoản",

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
                        _signInBloc.eventController.sink.add(InputUsername(username: value.toString()));
                        if (value == null ||
                            (!isValidEmail(value, isRequired: true))) {
                          return "Vui lòng nhập đúng định dạng email";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(

                      focusNode: FocusNode(),
                      controller: null,
                      hintText: " Mật khẩu",
                      margin: getMargin(
                        left: 6,
                        top: 25,
                        right: 2,
                      ),
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                      isObscureText: _showPass,
                      prefix: Container(
                        margin: getMargin(
                          left: 23,
                          top: 20,
                          right: 12,
                          bottom: 19,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.icPassword,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: getVerticalSize(
                          54,
                        ),
                      ),
                      suffix:  GestureDetector(
                        onTap: () {
                          setState(() {
                            onToggleShowPass();
                          });
                        },
                        child: Icon(
                          _showPass
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye_outlined,
                          color: _showPass
                              ? Colors.grey
                              : ColorConstant.primaryColor,
                          size: size.height * 0.028,
                        ),
                      ),

                      validator: (value) {
                        _signInBloc.eventController.sink.add(InputPassword(password: value.toString()));
                        if (value == null ||
                            (!isValidPassword(value, isRequired: true))) {
                          return "Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ thường, chữ in hoa và số";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: getPadding(
                        top: 13,
                        right: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(),));
                            },
                            child: Padding(
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
                      onTap: (){
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.

                          _signInBloc.eventController.sink.add(OnPressSignIn(context: context));

                        }
                      },
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
                      onTap: (){
                        setState(() {
                          // final provider = Provider.of<GoogleSignInProvider>(
                          //     context,
                          //     listen: false);
                          // provider.googleLogin();
                          GoogleSignInProvider().googleLogin();
                        });

                      },
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
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
                              },
                              child: Text(
                                "Đăng ký",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtInterSemiBold12Pr,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
