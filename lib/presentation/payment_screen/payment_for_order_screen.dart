import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:hommie/core/app_export.dart';

// ignore: must_be_immutable
class PaymentForOrderScreen extends StatefulWidget {
  const PaymentForOrderScreen({Key? key}) : super(key: key);

  @override
  State<PaymentForOrderScreen> createState() =>
      // ignore: no_logic_in_create_state
      _PaymentForOrderScreenState();
}

class _PaymentForOrderScreenState extends State<PaymentForOrderScreen> {
  // final OrderBloc = OrderBloc();
  bool isCheckedMomo = true;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.path;
      log("abc ${queryParams}");
      if (queryParams.isNotEmpty) {
        if (queryParams == "/success") {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const SuccessScreen(
          //           content:
          //           "Nạp tiền thành công. Cảm ơn bạn đã sử dụng dịch vụ",
          //           buttonName: "Trang chủ",
          //           navigatorPath: '/homeScreen'),
          //     ),
          //         (route) => false);
        } else {
          // showFailDialog(
          //     context, "Thanh toán không thành công. Vui lòng thử lại sau");
        }
      } else {}
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        // stream: OrderBloc.stateController.stream,
        builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              size: size.height * 0.03,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: const Text(
              "Thanh Toán Đặt Lịch",
            ),
          ),
          titleTextStyle: TextStyle(
            fontSize: size.height * 0.024,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          width: size.width,
          height: size.height * 0.12,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  // showConfirmPaymentForOrderDialog(context, "Xác nhận thanh toán cho đặt lịch này", OrderBloc, OrderID);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.height * 0.03),
                  ),
                  textStyle: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                ),
                child: const Text("Xác nhận"),
              ),
            ),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    left: size.width * 0.05,
                  ),
                  child: Text(
                    "Phương thức thanh toán",
                    style: TextStyle(
                      fontSize: size.height * 0.024,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  margin: EdgeInsets.only(
                    top: size.height * 0.02,
                  ),
                  padding: EdgeInsets.only(
                    top: size.height * 0.015,
                    bottom: size.height * 0.015,
                    left: size.width * 0.05,
                    right: size.width * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.icMomo,
                        width: size.height * 0.03,
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        "Momo",
                        style: TextStyle(
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => ColorConstant.primaryColor),
                        focusColor: ColorConstant.primaryColor,
                        value: isCheckedMomo,
                        onChanged: (bool? value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
