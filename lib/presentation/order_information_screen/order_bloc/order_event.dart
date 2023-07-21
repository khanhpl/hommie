import 'package:flutter/material.dart';

abstract class OrderEvent{}
class OtherOrderEvent extends OrderEvent{}
class InputAddress extends OrderEvent{
  InputAddress({required this.address});
  String address;
}
class InputPhone extends OrderEvent{
  InputPhone({required this.phone});
  String phone;
}
class CreateOrder extends OrderEvent{
  CreateOrder({required this.context});
  BuildContext context;
}
class GetAllOrder extends OrderEvent{}

class CancelOrder extends OrderEvent{
  CancelOrder({required this.context, required this.orderID, required this.reason});
  BuildContext context;
  int orderID;
  String reason;
}