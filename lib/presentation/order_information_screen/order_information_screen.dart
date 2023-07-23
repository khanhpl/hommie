// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:group_radio_button/group_radio_button.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/promo/promo_data.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_event.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_state.dart';
import 'package:hommie/presentation/order_information_screen/widgets/confirm_order_dialog.dart';
import 'package:hommie/presentation/order_information_screen/widgets/coupon_widget.dart';
import 'package:hommie/presentation/payment_screen/payment_for_order_screen.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_bloc.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_event.dart';

import '../../widgets/custom_text_form_field2.dart';
import '../promotion_screen/bloc/promo_state.dart';

class OrderInformationScreen extends StatefulWidget {
  OrderInformationScreen({Key? key, required this.totalPrice})
      : super(key: key);
  double totalPrice;

  @override
  State<OrderInformationScreen> createState() =>
      _OrderInformationScreenState(totalPrice: totalPrice);
}

class _OrderInformationScreenState extends State<OrderInformationScreen> {
  _OrderInformationScreenState({required this.totalPrice});

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
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    promoBloc.eventController.sink.add(GetAllPromo());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _orderBloc.stateController.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data is ReturnPromo){
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
              color: ColorConstant.primaryColor.withOpacity(0.1),
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
                          "Tổng tiền",
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
                          "${MoneyFormatter(amount: totalPrice + 40000 - ((selectedPromo != null) ? totalPrice*selectedPromo!.value : 0)).output.withoutFractionDigits} VNĐ",
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
                              "",
                              addressController.text.trim(),
                              phoneController.text.trim(),
                              (selectedPromo != null) ? selectedPromo!.code : "null");
                        } else if (_groupValue == "Thanh toán với ví Momo") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentForOrderScreen(),
                              ));
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
                          "Địa chỉ nhận hàng",
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
                          _orderBloc.eventController.sink.add(
                              InputAddress(address: value!.toString().trim()));
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
                          "Số điện thoại",
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
                          _orderBloc.eventController.sink
                              .add(InputPhone(phone: value!.toString().trim()));
                          if (value.toString().trim().isEmpty || value.toString().trim().length != 10) {
                            return "Vui lòng không để trống số điện thoại";
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
                          "Phương thức thanh toán",
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
                              "Số tiền mua hàng",
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
                              "Phí vận chuyển",
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
                              "40.000 VNĐ",
                              style: AppStyle.txtMedium14Black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StreamBuilder<Object>(
                              stream: promoBloc.stateController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data is ReturnAllPromo) {
                                    listPromo =
                                        (snapshot.data as ReturnAllPromo)
                                            .listPromo;
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
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Mã giảm giá',
                                              style:
                                                  AppStyle.txtRobotoRomanBold24,
                                            ),
                                            content: StatefulBuilder(
                                              builder: (context, setState) {
                                                return Material(
                                                  child: Container(
                                                    width: width,
                                                    height:
                                                        getVerticalSize(400),
                                                    color: Colors.white,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ListView.separated(

                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return couponWidget(
                                                                  context, listPromo[index], _orderBloc);
                                                            },
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    SizedBox(
                                                              height:
                                                                  getVerticalSize(
                                                                      10),
                                                            ),
                                                            itemCount: listPromo.length,
                                                            padding: const EdgeInsets.all(0),
                                                            scrollDirection: Axis.vertical,
                                                            physics: const BouncingScrollPhysics(),
                                                            shrinkWrap: true,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      "Chọn mã giảm",
                                      style: AppStyle.txtMedium14White,
                                    ),
                                  ),
                                );
                              }),
                          const Spacer(),
                          Padding(
                            padding: getPadding(
                              top: 30,
                              right: 10,
                            ),
                            child: Text(
                              "",
                              style: AppStyle.txtMedium14Black,
                            ),
                          ),
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
