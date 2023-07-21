import 'package:hommie/core/app_export.dart';

Future<void> showFeedbackSuccessDialog(
    BuildContext context) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstant.imgSuccess,
                    width: size.width * 0.64,
                    height: size.width * 0.5,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Đóng góp của bạn đã được ghi nhận',
                    textAlign: TextAlign.center,
                    style: AppStyle.txtRegular16Black,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    "Cảm ơn bạn đã sử dụng và góp ý cho chúng tôi",
                    textAlign: TextAlign.center,
                    style: AppStyle.txtRegular16Black,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    width: size.width * 0.4,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        // ignore: sort_child_properties_last
                        child: Row(children: [
                          Container(
                            width: size.width * 0.3,
                            alignment: Alignment.center,
                            child: Text(
                              'Xác nhận',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ),
                        ]),
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.homeScreen, ((route) => false))),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
