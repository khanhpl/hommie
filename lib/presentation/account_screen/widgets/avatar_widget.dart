import 'package:hommie/core/app_export.dart';

StatefulWidget avatarWidget(BuildContext context, String imgUrl) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        width: getHorizontalSize(50),
        height: getHorizontalSize(50),
        margin: getMargin(
          left: 20,
          right: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(ImageConstant.icProfile), fit: BoxFit.fill),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.edit,
            color: ColorConstant.primaryColor,
            size: getSize(20),
          ),
        ),
      );
    },
  );
}
