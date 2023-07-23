import '../../../core/models/promo/promo_data.dart';

abstract class PromoState{}
class ReturnAllPromo extends PromoState{
  ReturnAllPromo({required this.listPromo});
  List<PromoData> listPromo;
}