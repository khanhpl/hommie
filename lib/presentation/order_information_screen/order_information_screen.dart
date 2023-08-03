// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/cart_items/cart_items.dart';
import 'package:hommie/core/models/promo/promo_data.dart';
import 'package:hommie/presentation/bottom_bar_navigator/bottom_bar_navigator.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_state.dart';
import 'package:hommie/presentation/order_information_screen/widgets/add_promo_screen.dart';
import 'package:hommie/presentation/order_information_screen/widgets/cart_item_widget.dart';
import 'package:hommie/presentation/order_information_screen/widgets/confirm_order_dialog.dart';
import 'package:hommie/presentation/order_information_screen/widgets/coupon_widget.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_bloc.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_event.dart';
import 'package:hommie/widgets/dialog/success_dialog.dart';

import '../../widgets/custom_text_form_field2.dart';
import '../../widgets/dialog/fail_dialog.dart';
import '../order_list_screen/widget/item_in_order.dart';
import '../promotion_screen/bloc/promo_state.dart';

class OrderInformationScreen extends StatefulWidget {
  OrderInformationScreen(
      {Key? key, required this.totalPrice, required this.items})
      : super(key: key);
  double totalPrice;
  CartItems items;

  @override
  State<OrderInformationScreen> createState() =>
      _OrderInformationScreenState(totalPrice: totalPrice, items: items);
}

class _OrderInformationScreenState extends State<OrderInformationScreen> {
  _OrderInformationScreenState({required this.totalPrice, required this.items});

  CartItems items;
  double totalPrice;
  final _orderBloc = OrderBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final promoBloc = PromoBloc();
  final _paymentMethod = [
    "Thanh toán khi nhận hàng",
    "Thanh toán với ví Momo",
  ];
  List<PromoData> listPromo = [];
  PromoData? selectedPromo;
  String _groupValue = "Thanh toán khi nhận hàng";
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.path;
      log("abc ${queryParams} 222");
      if (queryParams.isNotEmpty) {
        if (queryParams == "/success") {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const SuccessScreen(
          //           content:
          //           "Nạp tiền thành công. Cảm ơn bạn đã sử dụng dịch vụ",
          //           buttonName: "Trang chủ",
          //           navigatorPath: '/homeScreen'),
          //     ),
          //         (route) => false);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => BottomBarNavigator(selectedIndex: 3, isBottomNav: true),), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Thanh toán và tạo đơn hàng thành công'),
              duration: Duration(seconds: 2),
            ),
          );
          print('Thanh toán thành công');
        } else {
            showFailDialog(
                context, "Thanh toán không thành công. Vui lòng thử lại sau");
          print('Thanh toán thất bại');
        }
      } else {}
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    promoBloc.eventController.sink.add(GetAllPromo());
    if (user != null) {
      phoneController = TextEditingController(text: user!.phoneNumber);

      receiverNameController = TextEditingController(text: user!.name);
    }
    if (userAddress.isNotEmpty) {
      addressController = TextEditingController(text: userAddress);
      phoneController = TextEditingController(text: phone);
    }
    initDynamicLinks();
  }

  double getDiscountPrice() {
    double discountPrice = 0;
    if (selectedPromo != null) {
      if (selectedPromo!.value % 1 == 0) {
        discountPrice = selectedPromo!.value;
      } else {
        if (totalPrice * selectedPromo!.value >=
            selectedPromo!.maxValueDiscount) {
          discountPrice = selectedPromo!.maxValueDiscount;
        } else {
          discountPrice = totalPrice * selectedPromo!.value;
        }
      }
    }
    return discountPrice;
  }

  double calTotalPrice() {
    double calculatedTotalPrice = 0;
    if (selectedPromo != null) {
      if (selectedPromo!.value % 1 == 0) {
        calculatedTotalPrice = totalPrice + 40000 - selectedPromo!.value;
      } else {
        calculatedTotalPrice = totalPrice + 40000 - getDiscountPrice();
      }
    } else {
      calculatedTotalPrice = totalPrice + 40000;
    }
    return calculatedTotalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _orderBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is ReturnPromo) {
            selectedPromo = (snapshot.data as ReturnPromo).promo;
          }
        }
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: CustomAppBar(
              height: getVerticalSize(60),
              leadingWidth: 45,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(right: 45),
                  child: Text(
                    "Đơn hàng",
                    style: AppStyle.txtRobotoRomanBold24,
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
              width: width,
              height: getHorizontalSize(140),
              color: ColorConstant.whiteA700,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 30,
                          left: 20,
                        ),
                        child: Text(
                          "Tổng thanh toán",
                          style: AppStyle.txtRobotoRomanBold20,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: getPadding(
                          top: 30,
                          right: 20,
                        ),
                        child: Text(
                          "${MoneyFormatter(amount: calTotalPrice()).output.withoutFractionDigits} VNĐ",
                          style: AppStyle.txtMedium14Black,
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    height: getVerticalSize(
                      54,
                    ),
                    text: "Xác nhận",
                    margin: getMargin(
                      left: 20,
                      top: 18,
                      right: 20,
                    ),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (_groupValue == "Thanh toán khi nhận hàng") {
                          showConfirmOrderDialog(
                              context,
                              40000,
                              "Trả Sau",
                              addressController.text.trim(),
                              phoneController.text.trim(),
                              (selectedPromo != null)
                                  ? selectedPromo!.code
                                  : "null",
                              calTotalPrice(),
                              receiverNameController.text.trim());
                        } else if (_groupValue == "Thanh toán với ví Momo") {
                          showConfirmOrderDialog(
                              context,
                              40000,
                              "Trả Trước",
                              addressController.text.trim(),
                              phoneController.text.trim(),
                              (selectedPromo != null)
                                  ? selectedPromo!.code
                                  : "null",
                              calTotalPrice(),
                              receiverNameController.text.trim());
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: Material(
              child: Container(
                width: width,
                height: height,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 30,
                          left: 20,
                        ),
                        child: Text(
                          "Địa chỉ nhận hàng:",
                          style: AppStyle.txtRobotoRomanBold20,
                        ),
                      ),
                      CustomTextFormField2(
                        focusNode: FocusNode(),
                        margin: getMargin(
                          top: 20,
                          left: 30,
                          right: 30,
                        ),
                        controller: addressController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return "Vui lòng không để trống địa chỉ";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: getPadding(
                          top: 30,
                          left: 20,
                        ),
                        child: Text(
                          "Tên người nhận:",
                          style: AppStyle.txtRobotoRomanBold20,
                        ),
                      ),
                      CustomTextFormField2(
                        focusNode: FocusNode(),
                        margin: getMargin(
                          top: 20,
                          left: 30,
                          right: 30,
                        ),
                        controller: receiverNameController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return "Vui lòng không để trống tên người nhận";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: getPadding(
                          top: 30,
                          left: 20,
                        ),
                        child: Text(
                          "Số điện thoại:",
                          style: AppStyle.txtRobotoRomanBold20,
                        ),
                      ),
                      CustomTextFormField2(
                        focusNode: FocusNode(),
                        margin: getMargin(
                          top: 20,
                          left: 30,
                          right: 30,
                        ),
                        controller: phoneController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value.toString().trim().isEmpty ||
                              value.toString().trim().length != 10) {
                            return "Số điện thoại phải có 10 ký tự";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: getPadding(
                          top: 30,
                          left: 20,
                        ),
                        child: Text(
                          "Phương thức thanh toán:",
                          style: AppStyle.txtRobotoRomanBold20,
                        ),
                      ),
                      Padding(
                        padding: getPadding(left: 30),
                        child: SizedBox(
                          width: width,
                          child: RadioGroup<String>.builder(
                            direction: Axis.vertical,
                            groupValue: _groupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => setState(() {
                              _groupValue = value ?? '';
                            }),
                            items: _paymentMethod,
                            textStyle: AppStyle.txtMedium14Black,
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 30,
                          left: 20,
                        ),
                        child: Text(
                          "Sản phẩm được chọn:",
                          style: AppStyle.txtRobotoRomanBold20,
                        ),
                      ),
                      SizedBox(height: getVerticalSize(15)),
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return cartItemWidget(context, items.data[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: items.data.length,
                      ),
                      Container(
                        height: 0.5,
                        width: width,
                        margin: getMargin(left: 40, right: 40),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: getPadding(
                              top: 30,
                              left: 20,
                            ),
                            child: Text(
                              "Tổng tiền hàng:",
                              style: AppStyle.txtRobotoRomanBold20,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: getPadding(
                              top: 30,
                              right: 20,
                            ),
                            child: Text(
                              "${MoneyFormatter(amount: totalPrice).output.withoutFractionDigits} VNĐ",
                              style: AppStyle.txtMedium14Black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: getPadding(
                              top: 30,
                              left: 20,
                            ),
                            child: Text(
                              "Phí vận chuyển:",
                              style: AppStyle.txtRobotoRomanBold20,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: getPadding(
                              top: 30,
                              right: 20,
                            ),
                            child: Text(
                              "40,000 VNĐ",
                              style: AppStyle.txtMedium14Black,
                            ),
                          ),
                        ],
                      ),
                      (selectedPromo != null)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    top: 30,
                                    left: 20,
                                  ),
                                  child: Text(
                                    "Áp dụng ưu đãi:",
                                    style: AppStyle.txtRobotoRomanBold20,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: getPadding(
                                    top: 30,
                                    right: 20,
                                  ),
                                  child: Text(
                                    "- ${MoneyFormatter(amount: getDiscountPrice()).output.withoutFractionDigits} VNĐ",
                                    style: AppStyle.txtMedium14BlackPr,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StreamBuilder<Object>(
                              stream: promoBloc.stateController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data is ReturnAllPromo) {
                                    listPromo =
                                        (snapshot.data as ReturnAllPromo)
                                            .listPromo
                                            .cast<PromoData>();
                                  }
                                }
                                return Padding(
                                  padding: getPadding(
                                    top: 30,
                                    left: 20,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorConstant.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              getSize(20))),
                                    ),
                                    onPressed: () {
                                      if (listPromo.isNotEmpty) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddPromoScreen(
                                                orderBloc: _orderBloc,
                                                listPromo: listPromo,
                                                totalPrice: totalPrice,
                                              ),
                                            ));
                                      }
                                    },
                                    child: Text(
                                      "Chọn mã giảm",
                                      style: AppStyle.txtMedium14White,
                                    ),
                                  ),
                                );
                              }),
                          (selectedPromo != null) ? Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: getHorizontalSize(200),
                              margin: getPadding(
                                left: 20,
                                top: 30,
                                right: 10,
                              ),
                              padding: getPadding(all: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(getSize(10)),
                                border: Border.all(
                                    width: 1,
                                    color: ColorConstant.primaryColor),
                              ),
                              child: Text(
                                "Mã: ${(selectedPromo != null) ? selectedPromo!.title : ""}",
                                style: AppStyle.txtMedium14Black,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ) : const SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: getVerticalSize(300),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
