import 'package:flutter/material.dart';

abstract class PersonalEvent{}
class OtherPersonalEvent extends PersonalEvent{}
class GetUserInfo extends PersonalEvent{}
class InputName extends PersonalEvent{
  InputName({required this.name});
  String name;
}
class InputPhone extends PersonalEvent{
  InputPhone({required this.phone});
  String phone;
}
class InputAddress extends PersonalEvent{
  InputAddress({required this.address});
  String address;
}
class ChooseGender extends PersonalEvent{
  ChooseGender({required this.gender});
  String gender;
}
class ChooseDOB extends PersonalEvent{
  ChooseDOB({required this.dob});
  String dob;
}
class UpdateInfo extends PersonalEvent{
  UpdateInfo({required this.context});
  BuildContext context;
}