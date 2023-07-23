import 'dart:async';
import 'dart:convert';
import 'package:hommie/core/models/promo/promo.dart';
import 'package:hommie/core/models/promo/promo_data.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_event.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_state.dart';
import 'package:http/http.dart' as http;
import 'package:hommie/core/app_export.dart';

class PromoBloc {
  final eventController = StreamController<PromoEvent>();
  final stateController = StreamController<PromoState>();
  PromoBloc(){
    eventController.stream.listen((event) {
      if(event is GetAllPromo){
        getAllPromo();
      }
    });
  }
  Future<void> getAllPromo() async {
    try {
      var url = Uri.parse(
          "https://tiemhommie-0835ad80e9db.herokuapp.com/api/promotion/get-all-promotion");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      print('Test getAllPromo status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        List<PromoData> listPromo = Promo.fromJson(jsonDecode(response.body)).data;
        stateController.sink.add(ReturnAllPromo(listPromo: listPromo));

      } else {
        print('fail msg: getAllPromo');
      }
    } finally {}
  }
}
