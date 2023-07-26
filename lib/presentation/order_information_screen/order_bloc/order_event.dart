import 'package:flutter/material.dart';
import 'package:hommie/core/models/promo/promo_data.dart';

abstract class OrderEvent {}

class OtherOrderEvent extends OrderEvent {}

class InputAddress extends OrderEvent {
  InputAddress({required this.address});

  String address;
}

class InputPhone extends OrderEvent {
  InputPhone({required this.phone});

  String phone;
}

class CreateOrder extends OrderEvent {
  CreateOrder(
      {required this.context,
      required this.feeShip,
      required this.paymentType,
      required this.address,
      required this.phone,
      required this.promoCode});

  BuildContext context;
  int feeShip;
  String paymentType;
  String address;
  String phone;
  String promoCode;
}

class CreateOrderPrePaid extends OrderEvent {
  CreateOrderPrePaid(
      {required this.context,
      required this.feeShip,
      required this.paymentType,
      required this.address,
      required this.phone,
      required this.promoCode,
      required this.totalPrice});

  BuildContext context;
  int feeShip;
  String paymentType;
  String address;
  String phone;
  String promoCode;
  double totalPrice;
}

class GetAllOrder extends OrderEvent {}

class CancelOrder extends OrderEvent {
  CancelOrder(
      {required this.context, required this.orderID, required this.reason});

  BuildContext context;
  int orderID;
  String reason;
}

class ChoosePromo extends OrderEvent {
  ChoosePromo({required this.promo});

  PromoData promo;
}
