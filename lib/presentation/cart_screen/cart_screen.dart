import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/cart_items/cart_items.dart';
import 'package:hommie/core/models/cart_items/datum.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_bloc.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_event.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_state.dart';
import 'package:hommie/presentation/cart_screen/widgets/cart_item.dart';
import 'package:hommie/presentation/order_information_screen/order_information_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _cartBloc = CartBloc();
  CartItems? cartItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartBloc.eventController.sink.add(ViewCart());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _cartBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ReturnCartItems) {
              print('Có load data nè');
              cartItems = (snapshot.data as ReturnCartItems).cartItems;
            }
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return Scaffold(
              appBar: CustomAppBar(
                height: getVerticalSize(60),
                leadingWidth: 45,
                leading: AppbarImage(
                    height: getVerticalSize(26),
                    width: getHorizontalSize(27),
                    svgPath: ImageConstant.imgCart,
                    margin: getMargin(top: 10, right: 2),
                    onTap: () {}),
                title: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(right: 45),
                    child: Text(
                      "Giỏ hàng",
                      style: AppStyle.txtRobotoRomanBold36,
                    ),
                  ),
                ),
              ),
              floatingActionButton: (cartItems != null && cartItems!.data.isNotEmpty) ? CustomButton(
                height: getVerticalSize(
                  54,
                ),
                text: "Đặt hàng",
                margin: getMargin(
                  left: 20,
                  top: 18,
                  right: 20,
                  bottom: 20,
                ),
                onTap: () {
                  double totalPrice = 0;
                  for (Datum item in cartItems!.data) {
                    totalPrice += item.price * item.quantity;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderInformationScreen(totalPrice: totalPrice),
                      ));
                },
              ) : const SizedBox(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Material(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (cartItems == null || cartItems!.data.isEmpty)
                            ? Column(
                              children: [
                                Padding(
                                    padding: getPadding(top: 30),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: ColorConstant.primaryColor,
                                      size: getSize(150),
                                    ),
                                  ),

                                Text("Giỏ hàng trống. Hãy thêm sản phẩm.", style: AppStyle.txtRegular16Black,),
                              ],
                            )
                            : Padding(
                                padding: getPadding(top: 30),
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return cartItem(
                                        context,
                                        cartItems!.data[index].itemName,
                                        cartItems!.data[index].material,
                                        cartItems!.data[index].color,
                                        cartItems!.data[index].quantity,
                                        cartItems!.data[index].price,
                                        cartItems!.data[index].itemImage,
                                        cartItems!.data[index].cartItemId);
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: getVerticalSize(20),
                                    );
                                  },
                                  itemCount: cartItems!.data.length,
                                ),
                              ),
                        SizedBox(height: getVerticalSize(200),),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: CustomAppBar(
                height: getVerticalSize(60),
                leadingWidth: 45,
                leading: AppbarImage(
                    height: getVerticalSize(26),
                    width: getHorizontalSize(27),
                    svgPath: ImageConstant.imgCart,
                    margin: getMargin(top: 10, right: 2),
                    onTap: () {}),
                title: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(right: 45),
                    child: Text(
                      "Giỏ hàng",
                      style: AppStyle.txtRobotoRomanBold36,
                    ),
                  ),
                ),
              ),
              floatingActionButton: CustomButton(
                height: getVerticalSize(
                  54,
                ),
                text: "Đặt hàng",
                margin: getMargin(
                  left: 20,
                  top: 18,
                  right: 20,
                  bottom: 20,
                ),
                onTap: () {
                  double totalPrice = 0;
                  for (Datum item in cartItems!.data) {
                    totalPrice += item.price * item.quantity;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderInformationScreen(totalPrice: totalPrice),
                      ));
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Material(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: getHorizontalSize(50),
                        ),
                        Center(
                          child: LoadingAnimationWidget.discreteCircle(
                              color: ColorConstant.primaryColor,
                              size: getSize(50)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
