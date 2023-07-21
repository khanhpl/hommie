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

class LoginWithGoogle extends SignInEvent {
  LoginWithGoogle({required this.context, required this.id, required this.fullName, required this.giveName, required this.familyName, required this.imgUrl, required this.email});
  BuildContext context;
  String id;
  String fullName;
  String giveName;
  String familyName;
  String imgUrl;
  String email;
}