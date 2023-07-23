import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_event.dart';

Future<void> showConfirmOrderDialog(BuildContext context,int feeShip, String paymentType, String address, String phone, String promoCode) async {
  final orderBloc = OrderBloc();
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
                  ImageConstant.imgConfirm,
                  width: size.width * 0.64,
                  height: size.width * 0.5,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Bạn có chắc chắn ?',
                  textAlign: TextAlign.center,
                  style: AppStyle.txtRegular16Black,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "Tiến hành đặt hàng.",
                  textAlign: TextAlign.center,
                  style: AppStyle.txtRegular16Black,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  children: [
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        // ignore: sort_child_properties_last
                        child: Container(
                          width: size.width * 0.3,
                          alignment: Alignment.center,
                          child: Text(
                            'Hủy',
                            textAlign: TextAlign.center,
                            style: AppStyle.txtRegular16Black,
                          ),
                        ),

                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.035,
                    ),
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        // ignore: sort_child_properties_last
                        child: Container(
                          width: size.width * 0.3,
                          alignment: Alignment.center,
                          child: Text(
                            'Xác nhận',
                            textAlign: TextAlign.center,
                            style: AppStyle.txtRegular16Black,
                          ),
                        ),
                        onPressed: () {
                          orderBloc.eventController.sink.add(CreateOrder(context: context, feeShip: feeShip, paymentType: paymentType, address: address, phone: phone, promoCode: promoCode));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
