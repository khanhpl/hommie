import 'package:hommie/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          width: width * 0.7,
          height: height * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgFrame),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
