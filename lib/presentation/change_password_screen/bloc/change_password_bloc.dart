

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:hommie/presentation/change_password_screen/bloc/change_password_event.dart';
import 'package:hommie/presentation/change_password_screen/bloc/change_password_state.dart';
import 'package:hommie/presentation/change_password_screen/widgets/change_pass_success_dialog.dart';
import 'package:hommie/widgets/dialog/fail_dialog.dart';

import '../../../core/app_export.dart';
import 'package:http/http.dart' as http;
class ChangePasswordBloc{
  final eventController = StreamController<ChangePasswordEvent>();
  final stateController = StreamController<ChangePasswordState>();
  ChangePasswordBloc(){
    eventController.stream.listen((event) {
      if(event is ChangePass){
        changePass(event.context, event.oldPass, event.newPass);
      }
    });
  }
  Future<void> changePass(BuildContext context, String oldPass, String newPass) async {
    print('${user!.email}-$oldPass-$newPass');
    try {
      var url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/user/change-password");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            "email": user!.email,
            "newPassword": newPass,
            "oldPassword": oldPass,
            "confirmPassword": newPass,
          },
        ),

      );
      print('Test changePass status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        showChangePassSuccessDialog(context);
      } else {
        showFailDialog(context, "Đổi mật khẩu thất bại");
      }
    } finally {}
  }
}