import 'package:hommie/core/app_export.dart';
class NoLoginScreen extends StatefulWidget {
  const NoLoginScreen({Key? key}) : super(key: key);

  @override
  State<NoLoginScreen> createState() => _NoLoginScreenState();
}

class _NoLoginScreenState extends State<NoLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        padding: getPadding(all: 30),
        height: getVerticalSize(300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(getSize(20)),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black90026,
              spreadRadius: getHorizontalSize(
                2,
              ),
              blurRadius: getHorizontalSize(
                2,
              ),
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Vui lòng đăng nhập để xem thêm ^^.", style: AppStyle.txtRegular16Black,),
            SizedBox(height: getVerticalSize(20),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(getSize(10))),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.googleNav);
              },
              child: Text(
                "Đăng nhập",
                style: AppStyle.txtMedium14White,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
