
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hommie/presentation/bottom_bar_navigator/bottom_bar_navigator.dart';
import 'package:hommie/presentation/sign_in_screen/sign_in_screen.dart';


class LoginWithGoogleNav extends StatefulWidget{
  const LoginWithGoogleNav({super.key});

  @override
  State<LoginWithGoogleNav> createState() => _LoginWithGoogleNavState();
}

class _LoginWithGoogleNavState extends State<LoginWithGoogleNav> {
  // final _elsBox = Hive.box('elsBox');
  // final _authenBloc = AuthenBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(_elsBox.get('checkLogin') != null){
    //   if(_elsBox.get('checkLogin')){
    //     _authenBloc.eventController.sink.add(MaintainLoginEvent(context));
    //   }
    // }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasData) {
            // return LoginWithGoogleSplitRole(user: FirebaseAuth.instance.currentUser!);
            return BottomBarNavigator(selectedIndex: 0, isBottomNav: true);
          } else if (snapshot.hasError) {
            return const SizedBox();
          } else {
            // if(_elsBox.get('checkLogin') != null){
            //   if(_elsBox.get('checkLogin')){
            //     return const SplashScreen();
            //   }else{
            //     return const LoginScreen();
            //   }
            // }else{
              return const SignInScreen();

            // }
          }
        },
      ),
    );
  }
}