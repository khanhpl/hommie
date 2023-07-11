// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:hommie/core/models/user_info/user_info.dart';
import 'package:hommie/presentation/personal_information_screen/personal_bloc/personal_event.dart';
import 'package:hommie/presentation/personal_information_screen/personal_bloc/personal_state.dart';
import 'package:hommie/core/app_export.dart';
import 'package:http/http.dart' as http;
class PersonalBloc{
  final eventController = StreamController<PersonalEvent>();
  final stateController = StreamController<PersonalState>();
  final String _controller = "/user";
  String _name = "";
  String _phone = "";
  String _address = "";
  String _gender = "";
  String _dob = "";
  PersonalBloc(){
    eventController.stream.listen((event) {
      if(event is OtherPersonalEvent){
        stateController.sink.add(OtherPersonalState());
      }
      if(event is GetUserInfo){
        getUserInfo();
      }
      if(event is InputName){
        _name = event.name;
      }
      if(event is InputPhone){
        _phone = event.phone;
      }
      if(event is InputAddress){
        _address = event.address;
      }
      if(event is ChooseGender){
        _gender = event.gender;
      }
      if(event is ChooseDOB){
        _dob = event.dob;
      }
      if(event is UpdateInfo){
        updateInfo(event.context);
      }
    });
  }
  Future<void> getUserInfo() async {
    try {
      var url = Uri.parse("$apiUrl$_controller/get-user-info?email=${user!.email}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },

      );
      print('Test getUserInfo status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        UserInfo userInfo = UserInfo.fromJson(json.decode(response.body));
        stateController.sink.add(ReturnUserInfo(userInfo: userInfo));
      } else {
        print('fail: ');
      }
    } finally {}
  }
  Future<void> updateInfo(BuildContext context) async {
    try {
      var url = Uri.parse("$apiUrl$_controller/update-user-info");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": user!.id,
            "name": _name,
            "phoneNumber": _phone,
            "address": _address,
            "gender": _gender,
            "dob": _dob
          },
        ),

      );
      print('Test updateInfo status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật thông tin thành công'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      } else {
        print('fail: ');
      }
    } finally {}
  }
}