import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hommie/presentation/home_screen/bloc/home_event.dart';
import 'package:hommie/presentation/home_screen/bloc/home_state.dart';
import 'package:hommie/core/app_export.dart';
import 'package:http/http.dart' as http;
import '../../../core/models/list_item/list_item.dart';

class HomeBloc {
  final eventController = StreamController<HomeEvent>();
  final stateController = StreamController<HomeState>();
  final String _controller = "/item";
  var _listItem;

  HomeBloc() {
    eventController.stream.listen((event) {
      if (event is OtherHomeEvent) {
        stateController.sink.add(OtherHomeState());
      }
      if (event is GetAllItems) {
        getLatestItems();
      }
    });
  }

  Future<void> getLatestItems() async {
    try {
      var url = Uri.parse("$apiUrl$_controller/get-top-new-item");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      if (response.statusCode.toString() == '200') {
        _listItem =
            ListItem.fromJson(json.decode(response.body));
        stateController.sink.add(ReturnLatestItems(listItem: _listItem));
      } else {
        if (kDebugMode) {
          print('fail msg: ');
        }
      }
    } finally {}
  }
}
