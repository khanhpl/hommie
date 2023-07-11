import 'package:hommie/core/models/order/order.dart';

abstract class OrderState{}
class OtherOrderState extends OrderState{}
class ReturnAllOrder extends OrderState{
  ReturnAllOrder({required this.order});
  Order order;
}