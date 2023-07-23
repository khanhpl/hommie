import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/promo/promo_data.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_event.dart';
Widget couponWidget(BuildContext context, PromoData promo, OrderBloc orderBloc){
  return Container(
    width: width,
    margin: getMarginOrPadding(
      top: 15,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
          size.height * 0.005),
      border: Border.all(
        width: 1,
        color: ColorConstant.primaryColor
            .withOpacity(0.5),
      ),
      color: ColorConstant.primaryColor
          .withOpacity(0.1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: size.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo.title,
                  style:
                  AppStyle.txtRobotoRomanMedium14,
                ),
                Text(
                  promo.description,
                  style:
                  AppStyle.txtRobotoRomanMedium14,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            orderBloc.eventController.sink.add(ChoosePromo(promo: promo));
            Navigator.pop(context);
          },
          child: Container(
            decoration: DottedDecoration(
              color: ColorConstant.primaryColor,
              strokeWidth: 0.5,
              linePosition: LinePosition.left,
            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.height * 0.01,
                bottom: size.height * 0.01,
              ),
              margin: EdgeInsets.only(
                top: size.height * 0.01,
                bottom: size.height * 0.01,
                left: size.width * 0.03,
                right: size.width * 0.03,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.primaryColor,
                borderRadius:
                BorderRadius.circular(
                    size.height * 0.005),
              ),
              child: Text("Chọn",
                  style:
                  AppStyle.txtMedium14White),
            ),
          ),
        ),
      ],
    ),
  );
}