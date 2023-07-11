import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/account_screen/widgets/avatar_widget.dart';
import 'package:hommie/presentation/account_screen/widgets/tab_element_widget.dart';
import 'package:hommie/presentation/personal_information_screen/personal_information_screen.dart';

import '../../core/fire_base/provider/google_sign_in_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInformationScreen(),));
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
              tabElementWidget(context, "Yêu thích", "", ""),
              tabElementWidget(context, "Lịch sử", "", ""),
              tabElementWidget(context, "Góp ý", "", ""),
              tabElementWidget(context, "Thông tin ứng dụng", "", ""),
              tabElementWidget(context, "Trò chuyện", "", ""),
              GestureDetector(
                onTap: (){
                  GoogleSignInProvider().logout();
                  // _elsBox.delete('checkLogin');
                  // _elsBox.delete('email');
                  // _elsBox.delete('password');
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.googleNav, (route) => false);
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
