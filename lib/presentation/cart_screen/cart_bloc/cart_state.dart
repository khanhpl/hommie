import 'package:hommie/core/models/cart_items/cart_items.dart';
import 'package:hommie/core/models/list_item/list_item_data.dart';

import '../../../core/models/list_item/detail_item.dart';

abstract class CartState {}

class OtherCartState extends CartState {}

class ReturnCartItems extends CartState {
  ReturnCartItems({required this.cartItems});

  CartItems cartItems;
}
class ReturnItemDetail extends CartState{
  ReturnItemDetail({required this.itemDetail});
  Detail itemDetail;
}