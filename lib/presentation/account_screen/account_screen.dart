import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:hive/hive.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/account_screen/widgets/avatar_widget.dart';
import 'package:hommie/presentation/account_screen/widgets/tab_element_widget.dart';
import 'package:hommie/presentation/app_information_screen/app_information_screen.dart';
import 'package:hommie/presentation/change_password_screen/change_password_screen.dart';
import 'package:hommie/presentation/feedback_screen/feedback_screen.dart';
import 'package:hommie/presentation/history_screen/history_screen.dart';
import 'package:hommie/presentation/personal_information_screen/personal_information_screen.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_event.dart';

import '../../core/fire_base/provider/google_sign_in_provider.dart';
import '../../widgets/dialog/fail_dialog.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var box = Hive.box('hommieBox');
  bool isGoogleLogin = false;
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  // Future<void> initDynamicLinks() async {
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     final Uri uri = dynamicLinkData.link;
  //     final queryParams = uri.path;
  //     log("abc ${queryParams} 1111");
  //     if (queryParams.isNotEmpty) {
  //       if (queryParams == "/success") {
  //         // Navigator.pushAndRemoveUntil(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //       builder: (context) => const SuccessScreen(
  //         //           content:
  //         //           "Nạp tiền thành công. Cảm ơn bạn đã sử dụng dịch vụ",
  //         //           buttonName: "Trang chủ",
  //         //           navigatorPath: '/homeScreen'),
  //         //     ),
  //         //         (route) => false);
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, AppRoutes.homeScreen, (route) => false);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Thanh toán và tạo đơn hàng thành công'),
  //             duration: Duration(seconds: 2),
  //           ),
  //         );
  //         print('Thanh toán thành công');
  //       } else {
  //         showFailDialog(
  //             context, "Thanh toán không thành công. Vui lòng thử lại sau");
  //         print('Thanh toán thất bại');
  //       }
  //     } else {}
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isGoogleLogin = (box.get('isGoogleLogin') != null) ? box.get('isGoogleLogin') : false;
    // initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: width,
        height: height,
        padding: getPadding(
          top: 50,
          bottom: 50,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalInformationScreen(),
                              ));
                        },
                        child: avatarWidget(context, ImageConstant.imgFrame)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Xin chào,",
                          style: AppStyle.txtRobotoRomanBold24,
                        ),
                        Text(
                          (user != null) ? user!.name : "",
                          style: AppStyle.txtRobotoRomanBold24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // GestureDetector(onTap:(){
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => TestDeepLinkScreen(),));
              // },child: tabElementWidget(context, "Yêu thích", "", "")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryScreen(),
                        ));

                  },
                  child: tabElementWidget(context, "Lịch sử", "", "")),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedBackScreen(),
                      ));
                },
                child: tabElementWidget(context, "Góp ý", "", ""),
              ),
              (!isGoogleLogin)
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordScreen(),
                            ));
                      },
                      child: tabElementWidget(context, "Đổi mật khẩu", "", ""))
                  : const SizedBox(),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AppInformationScreen(),));
                },
                  child: tabElementWidget(context, "Thông tin ứng dụng", "", "")),
              // tabElementWidget(context, "Trò chuyện", "", ""),
              // GestureDetector(
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => TestDeepLinkScreen(),));
              //     },
              //     child: tabElementWidget(context, "deep link", "", "")),
              GestureDetector(
                onTap: () {
                  GoogleSignInProvider().logout();
                  // _elsBox.delete('checkLogin');
                  // _elsBox.delete('email');
                  // _elsBox.delete('password');
                  box.put('isGoogleLogin', false);

                  box.put('isLogin', false);
                  SignInBloc().eventController.sink.add(SignOut());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã thoát khỏi tài khoản'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.homeScreen, (route) => false);
                  // _forgotBloc.eventController.sink
                  //     .add(LogoutEvent(context));
                },
                child: tabElementWidget(context, "Đăng xuất", "", ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
