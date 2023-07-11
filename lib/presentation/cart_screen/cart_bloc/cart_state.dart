import 'package:hommie/core/models/cart_items/cart_items.dart';

abstract class CartState {}

class OtherCartState extends CartState {}

class ReturnCartItems extends CartState {
  ReturnCartItems({required this.cartItems});

  CartItems cartItems;
}
