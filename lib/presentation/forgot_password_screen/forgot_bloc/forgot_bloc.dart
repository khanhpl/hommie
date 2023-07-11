
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hommie/presentation/forgot_password_screen/forgot_bloc/forgot_event.dart';
import 'package:hommie/presentation/forgot_password_screen/forgot_bloc/forgot_state.dart';
import 'package:hommie/widgets/dialog/fail_dialog.dart';
import 'package:http/http.dart' as http;
import '../../../core/app_export.dart';
import '../forgot_password_add_new_password.dart';

class ForgotBloc{
  final eventController = StreamController<ForgotEvent>();
  final stateController = StreamController<ForgotState>();
  final _controller = "/user";
  String _email = "";
  String _oldPass = "";
  String _passCode = "";
  String _newPass = "";
  ForgotBloc(){
    eventController.stream.listen((event) { 
      if(event is OtherForgotEvent){
        stateController.sink.add(OtherForgotState());
      }
      if(event is InputEmail){
        _email = event.email;
      }
      if(event is InputOldPass){
        _oldPass = event.oldPass;
      }
      if(event is InputNewPass){
        _newPass = event.newPass;
      }
      if(event is InputVerification){
        _passCode = event.code;
      }
      if(event is SendVerifyCode){
        sendVerifyCode(event.context);
      }
      if(event is ChangePass){
        changePass(event.context);
      }
    });
  }
  Future<void> sendVerifyCode(BuildContext context) async {
    try {
      var url = Uri.parse("$apiUrl$_controller/send-verificationCode?email=$_email");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
          },
        ),

      );
      if (response.statusCode.toString() == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mã đã được gửi đến email'),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordAddNewPasswordScreen(email: _email),));
      } else {
        if (kDebugMode) {
          print('fail msg: ${response.body.toString()}');
        }
      }
    } finally {}
  }
  Future<void> changePass(BuildContext context) async {
    try {
      var url = Uri.parse("$apiUrl$_controller/forgot-password");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": _email,
            "verificationCode": _passCode,
            "newPassword": _newPass
          },
        ),

      );
      print('Test changePass status :${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đổi mặt khẩu thành công'),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.googleNav, (route) => false);
      } else {
        showFailDialog(context, "Vui lòng kiểm tra lại mã xác nhận");
      }
    } finally {}
  }
}