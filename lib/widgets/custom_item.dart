import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/list_item/list_item_data.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_bloc.dart';
import 'package:hommie/widgets/item_detail_screen.dart';

// ignore: must_be_immutable
class CustomItem extends StatelessWidget {
  CustomItem({super.key, required this.item});
  ListItemData item;
  double avgRating = 0;
  final _cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailScreen(item: item),));
          },
          child: Container(
            height: getVerticalSize(
              209,
            ),
            width: getHorizontalSize(
              160,
            ),
            margin: getMargin(
              top: 20,
              right: 8,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: getMargin(
                          top: 16,
                        ),
                        padding: getPadding(
                          left: 10,
                          top: 12,
                          right: 10,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteA700,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.black90026,
                              spreadRadius: getHorizontalSize(
                                2,
                              ),
                              blurRadius: getHorizontalSize(
                                2,
                              ),
                              offset: const Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: getPadding(
                                left: 5,
                                top: 105,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: getVerticalSize(100),
                                    child: Text(
                                      item.name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRegular14Bluegray700,
                                    ),
                                  ),
                                  const Spacer(),
                                  // CustomImageView(
                                  //   svgPath:
                                  //       ImageConstant.imgAtomoestrellaactiva,
                                  //   height: getVerticalSize(
                                  //     15,
                                  //   ),
                                  //   width: getHorizontalSize(
                                  //     16,
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: getPadding(
                                  //     left: 3,
                                  //     top: 1,
                                  //     bottom: 1,
                                  //   ),
                                  //   child: Text(
                                  //     avgRating.ceil().toString(),
                                  //     overflow: TextOverflow.ellipsis,
                                  //     textAlign: TextAlign.left,
                                  //     style: AppStyle.txtRegular10,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 5,
                                top: 2,
                              ),
                              child: Text(
                                "${item.cateName}/${item.subName}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRegular10Bluegray7007f,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 5,
                                top: 9,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 12,
                                    ),
                                    child: Text(
                                      "${MoneyFormatter(amount: item.details[0].price.toDouble()).output.withoutFractionDigits} VND",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRegular14Bluegray700,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    color: ColorConstant.gray200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          10,
                        ),
                      ),
                    ),
                    child: Container(
                      height: getVerticalSize(
                        128,
                      ),
                      width: getHorizontalSize(
                        160,
                      ),
                      padding: getPadding(
                        left: 11,
                        top: 4,
                        right: 11,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.gray200,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            10,
                          ),
                        ),
                        image: DecorationImage(image: NetworkImage(item.avatar), fit: BoxFit.fill),
                      ),
                      // child: Stack(
                      //   alignment: Alignment.topCenter,
                      //   children: [
                      //
                      //     Align(
                      //       alignment: Alignment.topRight,
                      //       child: Card(
                      //         clipBehavior: Clip.antiAlias,
                      //         elevation: 0,
                      //         margin: getMargin(
                      //           top: 8,
                      //         ),
                      //         color: ColorConstant.yellow900,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(
                      //             getHorizontalSize(
                      //               10,
                      //             ),
                      //           ),
                      //         ),
                      //         child: Container(
                      //           height: getVerticalSize(
                      //             18,
                      //           ),
                      //           width: getHorizontalSize(
                      //             19,
                      //           ),
                      //           padding: getPadding(
                      //             left: 6,
                      //             top: 5,
                      //             right: 6,
                      //             bottom: 5,
                      //           ),
                      //           decoration: BoxDecoration(
                      //             color: ColorConstant.yellow900,
                      //             borderRadius: BorderRadius.circular(
                      //               getHorizontalSize(
                      //                 10,
                      //               ),
                      //             ),
                      //           ),
                      //           child: Stack(
                      //             children: [
                      //               CustomImageView(
                      //                 svgPath:
                      //                     ImageConstant.imgFavoriteWhiteA700,
                      //                 height: getVerticalSize(
                      //                   6,
                      //                 ),
                      //                 width: getHorizontalSize(
                      //                   7,
                      //                 ),
                      //                 alignment: Alignment.center,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
