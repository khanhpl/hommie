import 'package:flutter/material.dart';

abstract class SignInEvent {}

class OtherSignInEvent extends SignInEvent {}

class InputUsername extends SignInEvent {
  InputUsername({required this.username});

  String username;
}

class InputPassword extends SignInEvent {
  InputPassword({required this.password});

  String password;
}
class OnPressSignIn extends SignInEvent {
  OnPressSignIn({required this.context});
  BuildContext context;
}