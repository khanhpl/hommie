// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/feedback_screen/widgets/feedback_success_dialog.dart';
import 'package:hommie/presentation/report_screen/bloc/report_event.dart';
import 'package:hommie/presentation/report_screen/bloc/report_state.dart';
import 'package:http/http.dart' as http;
class ReportBloc{
  final eventController = StreamController<ReportEvent>();
  final stateController = StreamController<ReportState>();
  ReportBloc(){
    eventController.stream.listen((event) {
      if(event is ConfirmReport){
        sendReport(event.context, event.image, event.reason, event.orderCode);
      }
    });
  }
  Future<void> sendReport(BuildContext context, String image, String reason, String orderCode) async {
    try {
      var url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/report/create-report");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            "imageReport": image,
            "reason": reason,
            "userId": user!.id,
            "orderCode": orderCode
          },
        ),

      );
      print('Test sendReport status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
      showFeedbackSuccessDialog(context);
      } else {
        print('fail: sendReport');
      }
    } finally {}
  }
}