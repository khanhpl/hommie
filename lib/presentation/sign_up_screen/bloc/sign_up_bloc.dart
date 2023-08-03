// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hommie/presentation/sign_up_screen/bloc/sign_up_event.dart';
import 'package:hommie/presentation/sign_up_screen/bloc/sign_up_state.dart';
import 'package:hommie/widgets/dialog/fail_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:hommie/core/app_export.dart';

class SignUpBloc {
  final eventController = StreamController<SignUpEvent>();
  final stateController = StreamController<SignUpState>();
  final String _controller = "/user";

  String _username = "";
  String _password = "";
  String _rePassword = "";
  String _fullName = "";
  String _phone = "";

  SignUpBloc() {
    eventController.stream.listen((event) {
      if (event is OtherSignUpEvent) {
        stateController.sink.add(OtherSignUpState());
      }
      if (event is InputUsername) {
        _username = event.username.trim();
      }
      if (event is InputFullName) {
        _fullName = event.fullName.trim();
      }
      if (event is InputPhone) {
        _phone = event.phone.trim();
      }
      if (event is InputPassword) {
        _password = event.password.trim();
      }
      if (event is InputRePassword) {
        _rePassword = event.rePassword.trim();
      }
      if (event is OnPressSignUp) {
        signUp(event.context);
      }
    });
  }

  Future<void> signUp(BuildContext context) async {
    try {
        var url = Uri.parse("$apiUrl$_controller/register");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "name": _fullName,
            "email": _username,
            "phoneNumber": _phone,
            "password": _password,
          },
        ),
      );
      print('Test signUp statuscode: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        bearerToken = json.decode(response.body)["data"].toString();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng ký thành công'),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pop(context);
      } else {
        print('Test response: ${response.body.toString()}');
        showFailDialog(context, "Email đã được đăng ký");
      }
    } finally {}
  }
}
