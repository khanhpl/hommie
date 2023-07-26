
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:hommie/presentation/sign_in_screen/bloc/sign_in_event.dart';
import 'package:hommie/presentation/splash_screen/splash_screen.dart';

// ignore: must_be_immutable
class LoginWithGoogleSplitRole extends StatefulWidget {
  User user;

  LoginWithGoogleSplitRole({super.key, required this.user});

  @override
  State<LoginWithGoogleSplitRole> createState() =>
      // ignore: no_logic_in_create_state
      _LoginWithGoogleSplitRoleState(user: user);
}

class _LoginWithGoogleSplitRoleState extends State<LoginWithGoogleSplitRole> {
  User user;

  _LoginWithGoogleSplitRoleState({required this.user});

  final _signInBloc = SignInBloc();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _signInBloc.eventController.sink.add(LoginWithGoogle(context: context, id: user.uid, fullName: user.displayName!.toString(), giveName: "", familyName: "", imgUrl: user.photoURL!.toString(), email: user.email!.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // stream: _forgotBloc.stateController.stream,
      stream: null,
      builder: (context, snapshot) {
        // return const SplashScreen();
        return const SplashScreen();
      },
    );
    // TODO: implement build
  }
}
