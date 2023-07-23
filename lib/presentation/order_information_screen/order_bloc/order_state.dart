import 'package:hommie/core/models/order/order.dart';

import '../../../core/models/promo/promo_data.dart';

abstract class OrderState{}
class OtherOrderState extends OrderState{}
class ReturnAllOrder extends OrderState{
  ReturnAllOrder({required this.order});
  Order order;
}

class ReturnPromo extends OrderState{
  ReturnPromo({required this.promo});
  PromoData promo;
}
