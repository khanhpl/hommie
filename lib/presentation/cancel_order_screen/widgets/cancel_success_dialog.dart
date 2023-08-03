import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/bottom_bar_navigator/bottom_bar_navigator.dart';

Future<void> showCancelSuccessDialog(BuildContext context) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstant.imgForWard,
                    width: size.width * 0.64,
                    height: size.width * 0.5,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Thông báo',
                    textAlign: TextAlign.center,
                    style: AppStyle.txtRegular16Black,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    'Đơn hàng đã được hủy thành công',
                    textAlign: TextAlign.center,
                    style: AppStyle.txtRegular16Black,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      // ignore: sort_child_properties_last
                      child: Row(children: [
                        Container(
                          width: size.width * 0.44,
                          alignment: Alignment.center,
                          child: Text(
                            'Quản lý đơn hàng',
                            textAlign: TextAlign.center,
                            style: AppStyle.txtRegular16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: size.height * 0.03,
                          color: Colors.white,
                        ),
                      ]),
                      onPressed: () =>
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBarNavigator(selectedIndex: 3, isBottomNav: true),), (route) => false)),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                ],
              ),
            )),
      );
    },
  );
}
