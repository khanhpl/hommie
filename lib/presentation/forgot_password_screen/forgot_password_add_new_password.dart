import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/forgot_password_screen/forgot_bloc/forgot_bloc.dart';
import 'package:hommie/presentation/forgot_password_screen/forgot_bloc/forgot_event.dart';

// ignore: must_be_immutable
class ForgotPasswordAddNewPasswordScreen extends StatefulWidget {
  ForgotPasswordAddNewPasswordScreen({Key? key, required this.email})
      : super(key: key);
  String email;

  @override
  State<ForgotPasswordAddNewPasswordScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ForgotPasswordAddNewPasswordScreenState(email: email);
}

class _ForgotPasswordAddNewPasswordScreenState
    extends State<ForgotPasswordAddNewPasswordScreen> {
  _ForgotPasswordAddNewPasswordScreenState({required this.email});

  String email;
  bool _showPass = false;
  final _forgotBloc = ForgotBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _newPassController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forgotBloc.eventController.add(InputEmail(email: email));
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<Object>(
        stream: _forgotBloc.stateController.stream,
        builder: (context, snapshot) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: size.height * 0.03,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Form(
                key: _formKey,
                child: Container(
                  height: size.height,
                  width: size.width,
                  padding: EdgeInsets.only(
                    left: size.width * 0.07,
                    right: size.width * 0.07,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstant.imgForgotPassword1,
                          width: size.width,
                          height: size.height * 0.3,
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.05,
                          ),
                          child: Theme(
                            data: theme.copyWith(
                              colorScheme: theme.colorScheme
                                  .copyWith(primary: ColorConstant.primaryColor),
                            ),
                            child: TextFormField(
                              focusNode: FocusNode(),
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                  fontSize: size.width * 0.04, color: Colors.black),
                              cursorColor: ColorConstant.primaryColor,
                              controller: null,
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                _forgotBloc.eventController.sink.add(InputVerification(code: value.toString().trim()));
                                if (value == null || value.toString().trim().isEmpty) {
                                  return "Vui lòng nhập mã xác thực";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Mã xác thực",
                                border: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xffCED0D2), width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(6))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Theme(
                                data: theme.copyWith(
                                  colorScheme: theme.colorScheme.copyWith(
                                      primary: ColorConstant.primaryColor),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                  ),
                                  obscureText: !_showPass,
                                  validator: (value) {
                                    _forgotBloc.eventController.sink.add(InputNewPass(newPass: value.toString().trim()));
                                    if (value == null || !isValidPassword(value.toString().trim(), isRequired: true)) {
                                      return "Vui lòng nhập dúng định dạng mật khẩu";
                                    }
                                    return null;
                                  },
                                  cursorColor: ColorConstant.primaryColor,
                                  controller: _newPassController,
                                  decoration: InputDecoration(
                                    hintText: "Mật Khẩu mới",
                                    prefixIcon: SizedBox(
                                      width: size.width * 0.05,
                                      child: Icon(
                                        Icons.lock,
                                        size: size.width * 0.05,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(6))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: size.height * 0.02),
                                child: GestureDetector(
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
                                        ? ColorConstant.primaryColor
                                        : Colors.grey,
                                    size: size.height * 0.028,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Theme(
                                data: theme.copyWith(
                                  colorScheme: theme.colorScheme.copyWith(
                                      primary: ColorConstant.primaryColor),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                  ),
                                  obscureText: !_showPass,
                                  cursorColor: ColorConstant.primaryColor,
                                  controller: null,
                                  validator: (value) {
                                    if (value == null || value.toString().trim() != _newPassController.text.trim()) {
                                      return "Mật khẩu không trùng khớp";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Nhập lại mật khẩu",
                                    prefixIcon: SizedBox(
                                      width: size.width * 0.05,
                                      child: Icon(
                                        Icons.lock,
                                        size: size.width * 0.05,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(6))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: size.height * 0.02),
                                child: GestureDetector(
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
                                        ? ColorConstant.primaryColor
                                        : Colors.grey,
                                    size: size.height * 0.028,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        (snapshot.hasError)
                            ? Text(
                                snapshot.error.toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: size.height * 0.018,
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.1,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: size.height * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _forgotBloc.eventController.sink.add(ChangePass(context: context));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primaryColor,
                                textStyle: TextStyle(
                                  fontSize: size.width * 0.045,
                                ),
                              ),
                              child: const Text("Hoàn thành"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
