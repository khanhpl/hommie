import 'package:hommie/core/models/user_info/user_info.dart';

abstract class PersonalState{}
class OtherPersonalState extends PersonalState{}
class ReturnUserInfo extends PersonalState{
  ReturnUserInfo({required this.userInfo});
  UserInfo userInfo;
}