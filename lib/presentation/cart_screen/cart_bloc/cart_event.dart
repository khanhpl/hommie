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