import 'package:flutter/material.dart';

abstract class CartEvent{}
class OtherCartEvent extends CartEvent{}
class AddToCart extends CartEvent{
  AddToCart({required this.context, required this.quantity, required this.itemDetailID});
  BuildContext context;
  int quantity;
  int itemDetailID;
}
class ViewCart extends CartEvent{}
class DeleteItemFromCart extends CartEvent{
  DeleteItemFromCart({required this.cartItemID, required this.context});
  BuildContext context;
  int cartItemID;
}
class UpdateQuantityCartItem extends CartEvent{
  UpdateQuantityCartItem({required this.quantity, required this.cartItemID, required this.context});
  BuildContext context;
  int quantity;
  int cartItemID;
}
class ChooseItemDetail extends CartEvent{
  ChooseItemDetail({required this.itemDetailID});
  int itemDetailID;
}