// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:hommie/core/models/order/order.dart';
import 'package:hommie/presentation/cancel_order_screen/widgets/cancel_success_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:hommie/core/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/momo/momo.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc {
  final eventController = StreamController<OrderEvent>();
  final stateController = StreamController<OrderState>();

  OrderBloc() {
    eventController.stream.listen((event) {
      if (event is OtherOrderEvent) {
        stateController.sink.add(OtherOrderState());
      }

      if (event is CreateOrder) {
        createOrder(event.context, event.feeShip, event.paymentType, event.address, event.phone, event.promoCode);
      }
      if(event is GetAllOrder){
        getAllOrder();
      }
      if(event is CancelOrder){
        cancelOrder(event.context, event.orderID, event.reason);
      }
      if(event is ChoosePromo){

        stateController.sink.add(ReturnPromo(promo: event.promo));
      }
      if(event is CreateOrderPrePaid){
        // print('Test CreateOrderPrePaid: ${event.totalPrice}-${event.paymentType}-${event.address}-${event.feeShip}-${event.phone}-${event.promoCode}');
        createOrderPrepaid(event.context, event.feeShip, event.paymentType, event.address, event.phone, event.promoCode, event.totalPrice);
      }
    });
  }

  Future<void> createOrder(BuildContext context, int feeShip, String paymentType, String address, String phone, String promoCode) async {
    try {
      var url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/order/create-order-with-postpaid?userId=${user!.id}&feeShip=$feeShip&paymentType=$paymentType&shipAddress=$address&phoneNumber=$phone&promoCode=$promoCode");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      print('Test createOrder status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đặt hàng thành công'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false);
      } else {
        print('createOrder: ');
      }
    } finally {}
  }

  Future<void> createOrderPrepaid(BuildContext context, int feeShip, String paymentType, String address, String phone, String promoCode, double totalPrice) async {
    try {
      var url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/order/create-order-with-prepay?totalPrice=$totalPrice&paymentType=$paymentType&shipAddress=$address&feeShip=$feeShip&userId=${user!.id}&phoneNumber=$phone&promoCode=$promoCode");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      print('Test createOrderPrepaid status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Đặt hàng thành công'),
        //     duration: Duration(seconds: 2),
        //   ),
        // );
        // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false);
        Momo momo = Momo.fromJson(json.decode(response.body));
        String url = momo.data.body.payUrl;
        print('Test Url: $url');
        launchUrl(Uri.parse(url), mode: LaunchMode.externalNonBrowserApplication, );
        // if (await canLaunchUrl(Uri.parse(url))) {
        //   await launchUrl(Uri.parse(url),
        //       mode: LaunchMode.externalNonBrowserApplication);
        // }
      } else {
        print('createOrderPrepaid: fail');
      }
    } finally {}
  }
  Future<void> getAllOrder() async {
    try {
      var url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/order/get-all-my-order?userId=${user!.id}");
        final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      print('Test getAllOrder status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        Order order = Order.fromJson(jsonDecode(response.body));
        stateController.sink.add(ReturnAllOrder(order: order));

      } else {
        print('fail msg: getAllOrder');
      }
    } finally {}
  }
  Future<void> cancelOrder(BuildContext context, int orderID, String reason) async {
    try {
      var url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/order/cancel-order?orderId=$orderID&cancelReason=$reason");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      print('Test cancelOrder status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        showCancelSuccessDialog(context);
      } else {
        print('cancelOrder: ');
      }
    } finally {}
  }
}
