// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
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
      if(event is LoginWithGoogle){
        loginWithGoogle(event.context, event.id, event.fullName, event.giveName, event.familyName, event.imgUrl, event.email);
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
        var box = Hive.box('hommieBox');
        box.put('isGoogleLogin', false);
        box.put('isLogin', true);
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
  Future<void> loginWithGoogle(BuildContext context, String id, String fullName, String giveName, String familyName, String imageUrl, String email) async {
    print('Test deviceID: $deviceID');
    try {
      var url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/user/login-with-google?fcmKey=$deviceID");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "id": id,
            "fullname": fullName,
            "givenname": giveName,
            "familyname": familyName,
            "imageUrl": imageUrl,
            "email": email
          },
        ),
      );
      print('Test loginWithGoogle statuscode: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        bearerToken = json.decode(response.body)["data"].toString();
        print('Test bearer: $bearerToken');
        user = User.fromJson(Jwt.parseJwt(bearerToken));
        print('Test user: ${user!.name}');
        var box = Hive.box('hommieBox');
        box.put('isGoogleLogin', true);
        box.put('isLogin', true);

        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false,);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập thành công'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        showFailDialog(context, "Tài khoản hoặc mật khẩu không đúng");
        print('Test fail: ${response.body.toString()}');
      }
    } finally {}
  }
  Future<void> signOut() async {

    try {
      var url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/user/logout?userName=${user!.email}");
      final response = await http.put(
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
      print('Test loginWithGoogle statuscode: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {

      } else {
        print('Test fail: ${response.body.toString()}');
      }
    } finally {}
  }
}
