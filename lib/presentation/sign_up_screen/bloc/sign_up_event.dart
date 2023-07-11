import 'package:flutter/material.dart';

abstract class SignUpEvent {}

class OtherSignUpEvent extends SignUpEvent {}

class InputUsername extends SignUpEvent {
  InputUsername({required this.username});

  String username;
}
class InputFullName extends SignUpEvent {
  InputFullName({required this.fullName});

  String fullName;
}
class InputPhone extends SignUpEvent {
  InputPhone({required this.phone});

  String phone;
}
class InputPassword extends SignUpEvent {
  InputPassword({required this.password});

  String password;
}
class InputRePassword extends SignUpEvent {
  InputRePassword({required this.rePassword});

  String rePassword;
}
class OnPressSignUp extends SignUpEvent {
  OnPressSignUp({required this.context});
  BuildContext context;
}