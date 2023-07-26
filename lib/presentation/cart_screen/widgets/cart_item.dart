import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/cart_items/datum.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_bloc.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_event.dart';

StatefulWidget cartItem(BuildContext context, Datum item) {
  final cartBloc = CartBloc();
  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        width: width,
        margin: getMargin(top: 20),
        padding: getPadding(
          top: 12,
          bottom: 12,
          left: 20,
          right: 20,
        ),
        color: ColorConstant.whiteA700,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              url: item.itemImage,
              height: getHorizontalSize(
                80,
              ),
              width: getHorizontalSize(
                80,
              ),
              alignment: Alignment.topCenter,
            ),
            SizedBox(
              width: getHorizontalSize(10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getHorizontalSize(180),
                  child: Text(
                    item.itemName,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRobotoRomanBold20,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 2,
                  ),
                  child: Text(
                    "${item.color}-${item.size}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRegular16Gray,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 2,
                  ),
                  child: Text(
                    "${item.price.ceil().toString()} VNĐ/sp",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRegular16Gray,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: getPadding(top: 20),
                  child: Row(
                    children: [

                      Container(
                        alignment: Alignment.center,
                        padding: getPadding(all: 5),
                        decoration: BoxDecoration(
                          color: ColorConstant.primaryColor,
                          borderRadius: BorderRadius.circular(getSize(3)),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            cartBloc.eventController.sink.add(UpdateQuantityCartItem(quantity: item.quantity-1, cartItemID: item.cartItemId, context: context));
                          },
                          child: Icon(
                            Icons.remove,
                            size: getSize(15),
                            color: ColorConstant.whiteA700,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: getMargin(left: 5, right: 5),
                        padding: getPadding(all: 5),
                        child: Text(
                          item.quantity.toString(),
                          style: AppStyle.txtMedium14Black,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: getPadding(all: 5),
                        decoration: BoxDecoration(
                          color: ColorConstant.primaryColor,
                          borderRadius: BorderRadius.circular(getSize(3)),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            cartBloc.eventController.sink.add(UpdateQuantityCartItem(quantity: item.quantity+1, cartItemID: item.cartItemId, context: context));
                          },
                          child: Icon(
                            Icons.add,
                            size: getSize(15),
                            color: ColorConstant.whiteA700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      );
    },
  );
}
