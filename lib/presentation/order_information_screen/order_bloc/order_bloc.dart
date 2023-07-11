// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:hommie/core/models/order/order.dart';
import 'package:http/http.dart' as http;
import 'package:hommie/core/app_export.dart';

import 'order_event.dart';
import 'order_state.dart';

class OrderBloc {
  final eventController = StreamController<OrderEvent>();
  final stateController = StreamController<OrderState>();
  String _address = "";
  String _phone = "";
  int _feeShip = 30000;
  String _paymentType = "Trả sau";
  String _promoCode = "null";

  OrderBloc() {
    eventController.stream.listen((event) {
      if (event is OtherOrderEvent) {
        stateController.sink.add(OtherOrderState());
      }
      if (event is InputAddress) {
        _address = event.address;
      }
      if (event is InputPhone) {
        _phone = event.phone;
      }
      if (event is CreateOrder) {
        createOrder(event.context);
      }
      if(event is GetAllOrder){
        getAllOrder();
      }
    });
  }

  Future<void> createOrder(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/order/create-order-with-postpaid?userId=${user!.id}&feeShip=$_feeShip&paymentType=$_paymentType&shipAddress=$_address&phoneNumber=$_phone&promoCode=$_promoCode");
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
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false);
      } else {
        print('createOrder: ');
      }
    } finally {}
  }
  Future<void> getAllOrder() async {
    try {
      var url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/order/get-all-order?userId=${user!.id}");
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
}
