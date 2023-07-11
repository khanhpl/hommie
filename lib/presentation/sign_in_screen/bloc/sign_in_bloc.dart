// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:hommie/core/models/user/user.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:hommie/widgets/dialog/fail_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_event.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_state.dart';

class SignInBloc {
  final eventController = StreamController<SignInEvent>();
  final stateController = StreamController<SignInState>();
  final String _controller = "/user";

  String _username = "";
  String _password = "";

  SignInBloc() {
    eventController.stream.listen((event) {
      if (event is OtherSignInEvent) {
        stateController.sink.add(OtherSignInState());
      }
      if (event is InputUsername) {
        _username = event.username;
      }
      if (event is InputPassword) {
        _password = event.password;
      }
      if (event is OnPressSignIn) {
        loginWithAccount(event.context);
      }
    });
  }

  Future<void> loginWithAccount(BuildContext context) async {
    try {
      var url = Uri.parse("$apiUrl$_controller/login");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': _username,
            'password': _password,
            'fcmKey': deviceID,
          },
        ),
      );
      print('Test loginWithAccount statuscode: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        bearerToken = json.decode(response.body)["data"].toString();
        user = User.fromJson(Jwt.parseJwt(bearerToken));
        print('Test user: ${user!.name}');
        Jwt.parseJwt(bearerToken);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập thành công'),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false,);
      } else {
        showFailDialog(context, "Tài khoản hoặc mật khẩu không đúng");
      }
    } finally {}
  }
}
