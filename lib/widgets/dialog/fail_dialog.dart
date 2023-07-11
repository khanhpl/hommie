import 'package:hommie/core/app_export.dart';

Future<void> showFailDialog(BuildContext context, String errorMsg) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
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
                  ImageConstant.imgFail,
                  width: size.width * 0.64,
                  height: size.width * 0.5,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Không thành công',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: size.height * 0.036,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  errorMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
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
                      backgroundColor: Colors.red,
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          //     child: Container(
          //       width: size.width,
          //       decoration: const BoxDecoration(
          //         color: Colors.transparent,
          //       ),
          //       child: Text(
          //         errorMsg,
          //       ),
          //     )),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Xác nhận'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        ),
      );
    },
  );
}
