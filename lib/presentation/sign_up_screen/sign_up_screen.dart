import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:hommie/presentation/sign_up_screen/bloc/sign_up_event.dart';
import '../../core/fire_base/provider/google_sign_in_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _signUpBloc = SignUpBloc();
  final _passwordController = TextEditingController();
  bool _showPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: ColorConstant.whiteA700,
      resizeToAvoidBottomInset: false,
      body: Material(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: StreamBuilder<Object>(
              stream: _signUpBloc.stateController.stream,
              builder: (context, snapshot) {
                return Container(
                  width: double.maxFinite,
                  padding: getPadding(
                    left: 18,
                    right: 18,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 22,
                          ),
                          child: Text(
                            "Đăng ký tài khoản",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoRomanBold36,
                          ),
                        ),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: null,
                          hintText: "email(tên đăng nhập)",
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
                            _signUpBloc.eventController.sink
                                .add(InputUsername(username: value.toString()));
                            if (value == null ||
                                (!isValidEmail(value, isRequired: true))) {
                              return "Vui lòng nhập đúng định dạng email";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          hintText: "Họ và tên",
                          focusNode: FocusNode(),
                          controller: null,
                          margin: getMargin(
                            left: 6,
                            top: 25,
                            right: 2,
                          ),
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          isObscureText: false,
                          prefix: Container(
                              margin: getMargin(
                                left: 23,
                                top: 20,
                                right: 12,
                                bottom: 19,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              )),
                          prefixConstraints: BoxConstraints(
                            maxHeight: getVerticalSize(
                              54,
                            ),
                          ),
                          validator: (value) {
                            _signUpBloc.eventController.sink
                                .add(InputFullName(fullName: value.toString()));

                            if (value == null ||
                                value.toString().trim().isEmpty ) {
                              return "Vui lòng nhập họ và tên";
                            }else if(value.toString().length >= 50){
                              return "Họ và tên chỉ được tối đa 50 ký tự";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          hintText: "Số điện thoại",
                          focusNode: FocusNode(),
                          controller: null,
                          margin: getMargin(
                            left: 6,
                            top: 25,
                            right: 2,
                          ),
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.phone,
                          isObscureText: false,
                          prefix: Container(
                              margin: getMargin(
                                left: 23,
                                top: 20,
                                right: 12,
                                bottom: 19,
                              ),
                              child: const Icon(
                                Icons.phone,
                                color: Colors.black,
                              )),
                          prefixConstraints: BoxConstraints(
                            maxHeight: getVerticalSize(
                              54,
                            ),
                          ),
                          validator: (value) {
                            _signUpBloc.eventController.sink
                                .add(InputPhone(phone: value.toString()));

                            if (value.toString().trim().isEmpty || value.toString().trim().length != 10) {
                              return "Số điện thoại phải có 10 ký tự";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          hintText: "Mật khẩu",
                          focusNode: FocusNode(),
                          controller: _passwordController,
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
                          suffix: GestureDetector(
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
                            _signUpBloc.eventController.sink
                                .add(InputPassword(password: value.toString()));
                            if (value == null ||
                                (!isValidPassword(value, isRequired: true))) {
                              return "Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ thường, chữ in hoa và số";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          hintText: "Nhập lại mật khẩu",
                          focusNode: FocusNode(),
                          controller: null,

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
                          suffix: GestureDetector(
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
                            _signUpBloc.eventController.sink.add(
                                InputRePassword(rePassword: value.toString()));
                            if (value == null ||
                                value.toString().trim() !=
                                    _passwordController.text.trim()) {
                              return "Mật khẩu chưa trùng khớp";
                            }
                            return null;
                          },
                        ),
                        CustomButton(
                          height: getVerticalSize(
                            54,
                          ),
                          text: "Đăng ký",
                          margin: getMargin(
                            left: 6,
                            top: 18,
                            right: 2,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.

                              _signUpBloc.eventController.sink
                                  .add(OnPressSignUp(context: context));
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
                          onTap: () {
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
                          fontStyle:
                              ButtonFontStyle.RobotoRomanMedium15Black900,
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
                                  "Đã có tài khoản",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtInterRegular12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: getPadding(
                                    left: 9,
                                    top: 1,
                                  ),
                                  child: Text(
                                    "Đăng nhập",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtInterSemiBold12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: getVerticalSize(200),),
                      ],
                    ),
                  ),
                );
              }),
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
