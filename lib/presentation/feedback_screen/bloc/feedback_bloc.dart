// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:hommie/presentation/feedback_screen/bloc/feedback_event.dart';
import 'package:hommie/presentation/feedback_screen/bloc/feedback_state.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/feedback_screen/widgets/feedback_success_dialog.dart';
import 'package:http/http.dart' as http;
class FeedBackBloc{
  final eventController = StreamController<FeedbackEvent>();
  final stateController = StreamController<FeedBackState>();
  FeedBackBloc(){
    eventController.stream.listen((event) {
      if(event is ConfirmFeedBack){
        sendFeedBack(event.context, event.content);
      }
    });
  }
  Future<void> sendFeedBack(BuildContext context, String content) async {
    try {
      var url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/feedback/create-feedback?email=${user!.email}&content=$content");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
          },
        ),

      );
      print('Test sendFeedBack status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
      showFeedbackSuccessDialog(context);
      } else {
        print('fail: sendFeedBack');
      }
    } finally {}
  }
}