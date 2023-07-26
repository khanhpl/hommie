// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/order/order_data.dart';
import 'package:hommie/presentation/order_list_screen/widget/custom_order_button.dart';
import 'package:hommie/presentation/order_list_screen/widget/item_in_order.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({Key? key, required this.orderData}) : super(key: key);
  OrderData orderData;

  @override
  State<OrderDetail> createState() => _OrderDetailState(orderData: orderData);
}

class _OrderDetailState extends State<OrderDetail> {
  _OrderDetailState({required this.orderData});

  OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
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
                  "Chi Tiết Đơn Hàng",
                  style: AppStyle.txtRobotoRomanBold36,
                ),
              ),
            ),
          ),
          floatingActionButton: customOrderButton(context, orderData.orderStatus, orderData.orderId,orderData.orderCode),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          body: Material(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width,
                      padding: getPadding(all: 10),
                      margin: getMargin(left: 22, right: 22, top: 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(getSize(20)),
                          border: Border.all(
                            width: 1,
                            color: ColorConstant.primaryColor.withOpacity(0.5),
                          )),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 2 - getHorizontalSize(32),
                                child: Text(
                                  "Mã đơn hàng:",
                                  style: AppStyle.txtRegular16Black,
                                ),
                              ),
                              Expanded(
                                child: Text(

                                  orderData.orderCode,
                                  textAlign: TextAlign.end,
                                  style: AppStyle.txtRegular16Black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getVerticalSize(15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 2 - getHorizontalSize(32),
                                child: Text(
                                  "Sản phẩm được chọn:",
                                  style: AppStyle.txtRegular16Black,
                                ),
                              ),
                              SizedBox(height: getVerticalSize(15)),
                              ListView.separated(
                                padding: const EdgeInsets.all(0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return itemInOrderList(context, orderData.listItems[index]);
                                },
                                separatorBuilder: (context, index) => const SizedBox(),
                                itemCount: orderData.listItems.length,
                              ),
                              Container(
                                width: width,
                                height: 0.5,
                                color: Colors.grey.withOpacity(0.5),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getVerticalSize(15),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width / 2 - getHorizontalSize(32),
                                child: Text(
                                  "Tổng tiền:",
                                  style: AppStyle.txtRegular16Black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${MoneyFormatter(amount: orderData.totalPrice).output.withoutFractionDigits} VNĐ",
                                  textAlign: TextAlign.end,
                                  style: AppStyle.txtRegular16Black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getVerticalSize(15),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width / 2 - getHorizontalSize(32),
                                child: Text(
                                  "Trạng thái:",
                                  style: AppStyle.txtRegular16Black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  orderData.orderStatus,
                                  textAlign: TextAlign.end,
                                  style: AppStyle.txtRegular16Black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
