import 'package:hommie/core/app_export.dart';
Widget tabElementWidget(BuildContext context, String title, String path, String icPath){
  return Container(
    width: width,
    margin: getMargin(
      top: 20,
    ),
    padding: getPadding(
      top: 10,
      bottom: 10,
      left: 20,
      right: 20,
    ),
    decoration: BoxDecoration(
        color: ColorConstant.whiteA700,
      border: Border(
        top: BorderSide(width: 1, color: ColorConstant.gray200),
        bottom: BorderSide(width: 1, color: ColorConstant.gray200),
      )
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyle.txtMedium14Black,
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios_sharp, color: ColorConstant.gray600, size: getSize(20),),
      ],
    ),
  );
}