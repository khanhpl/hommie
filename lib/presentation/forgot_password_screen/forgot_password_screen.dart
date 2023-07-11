import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/forgot_password_screen/forgot_bloc/forgot_bloc.dart';
import 'package:hommie/presentation/forgot_password_screen/forgot_bloc/forgot_event.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotBloc = ForgotBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                onTap: (){
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
                  left: size.width*0.07,
                  right: size.width*0.07,
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
                          top: size.height*0.03,
                        ),
                        child: Text(
                          'Vui lòng nhập email đã đăng ký',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: size.height*0.022,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height*0.03,
                        ),
                        child: Text(
                          'Mã xác thực sẽ được gửi đến email này',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height*0.02,
                          ),
                        ),
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
                              _forgotBloc.eventController.sink.add(InputEmail(email: value.toString().trim()));
                              if (value == null ||
                                  (!isValidEmail(value, isRequired: true))) {
                                return "Vui lòng nhập đúng định dạng email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: SizedBox(
                                width: size.width * 0.05,
                                child: Icon(
                                  Icons.email,
                                  size: size.width * 0.05,
                                ),
                              ),
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
                          top: size.height * 0.1,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _forgotBloc.eventController.sink.add(SendVerifyCode(context: context));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              textStyle: TextStyle(
                                fontSize: size.width * 0.045,
                              ),
                            ),
                            child: const Text("Tiếp tục"),
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
      }
    );
  }
}
