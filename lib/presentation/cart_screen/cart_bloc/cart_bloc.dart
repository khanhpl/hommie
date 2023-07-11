// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:hommie/core/models/cart_items/cart_items.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_event.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_state.dart';
import 'package:hommie/core/app_export.dart';
import 'package:http/http.dart' as http;

class CartBloc {
  final eventController = StreamController<CartEvent>();
  final stateController = StreamController<CartState>();
  CartBloc() {
    eventController.stream.listen((event) {
      if (event is OtherCartEvent) {
        stateController.sink.add(OtherCartState());
      }
      if (event is AddToCart) {
        addToCart(event.context, event.quantity, event.itemDetailID);
      }
      if(event is ViewCart){
        viewCart();
      }
    });
  }

  Future<void> addToCart(BuildContext context, quantity, itemDetailID) async {
    try {
      Uri url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/cart-item/add-to-cart");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(
          <String, dynamic>{
            "userId": user!.id,
            "itemDetailId": itemDetailID,
            "quantity": quantity,
          },
        ),
      );
      print('Test addToCart status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã thêm vào giỏ hàng'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print('fail: addToCart');
      }
    } finally {}
  }
  Future<void> viewCart() async {
    try {
      Uri url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/cart-item/view-my-cart?userId=${user!.id}");

      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },

      );
      print('Test viewCart status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        CartItems cartItems = CartItems.fromJson(json.decode(response.body));
        stateController.sink.add(ReturnCartItems(cartItems: cartItems));
      } else {
        print('fail: viewCart');
      }
    } finally {}
  }
}
