
import 'package:hommie/core/app_export.dart';

Future<void> showSuccessDialog(
    BuildContext context, String content) async {
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
                    'Thành công !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: size.height * 0.035,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.normal,
                      fontSize: size.height * 0.022,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    width: size.width * 0.4,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
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
                        onPressed: () => Navigator.pop(context),),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
