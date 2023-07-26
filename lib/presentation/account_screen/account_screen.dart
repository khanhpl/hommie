import 'package:hive/hive.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/account_screen/widgets/avatar_widget.dart';
import 'package:hommie/presentation/account_screen/widgets/tab_element_widget.dart';
import 'package:hommie/presentation/app_information_screen/app_information_screen.dart';
import 'package:hommie/presentation/change_password_screen/change_password_screen.dart';
import 'package:hommie/presentation/feedback_screen/feedback_screen.dart';
import 'package:hommie/presentation/history_screen/history_screen.dart';
import 'package:hommie/presentation/personal_information_screen/personal_information_screen.dart';
import 'package:hommie/presentation/splash_screen/splash_screen.dart';
import 'package:hommie/presentation/test_deep_link_screen/test_deep_link_screen.dart';

import '../../core/fire_base/provider/google_sign_in_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var box = Hive.box('hommieBox');
  bool isGoogleLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isGoogleLogin = box.get('isGoogleLogin');
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
              GestureDetector(
                onTap: () {
                  GoogleSignInProvider().logout();
                  // _elsBox.delete('checkLogin');
                  // _elsBox.delete('email');
                  // _elsBox.delete('password');
                  box.put('isGoogleLogin', false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.googleNav, (route) => false);
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
