// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:group_radio_button/group_radio_button.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_event.dart';

import '../../widgets/custom_text_form_field2.dart';
class OrderInformationScreen extends StatefulWidget {
  OrderInformationScreen({Key? key, required this.totalPrice}) : super(key: key);
  double totalPrice;
  @override
  State<OrderInformationScreen> createState() => _OrderInformationScreenState(totalPrice: totalPrice);
}

class _OrderInformationScreenState extends State<OrderInformationScreen> {
  _OrderInformationScreenState({required this.totalPrice});
  double totalPrice;
  final _orderBloc = OrderBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _paymentMethod = ["Thanh toán khi nhận hàng"];
  String _groupValue = "Thanh toán khi nhận hàng";
  @override
  Widget build(BuildContext context) {

    return  StreamBuilder(
      stream: _orderBloc.stateController.stream,
      builder: (context, snapshot) {
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
            height: getHorizontalSize(150),
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
                      child: Text("Tổng tiền", style: AppStyle.txtRobotoRomanBold20,),

                    ),
                    const Spacer(),
                    Padding(
                      padding: getPadding(
                        top: 30,
                        right: 20,
                      ),
                      child: Text("${totalPrice+40000} VNĐ", style: AppStyle.txtMedium14Black,),

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
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                    _orderBloc.eventController.sink.add(CreateOrder(context: context));
                    }
                  },
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                      child: Text("Địa chỉ nhận hàng", style: AppStyle.txtRobotoRomanBold20,),
                    ),
                    CustomTextFormField2(
                      focusNode: FocusNode(),
                      margin: getMargin(
                          top: 20,
                        left: 30,
                        right: 30,
                      ),
                      controller: null,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.streetAddress,
                      validator: (value) {
                        _orderBloc.eventController.sink.add(InputAddress(address: value!.toString().trim()));
                        if(value.toString().trim().isEmpty){
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
                      child: Text("Số điện thoại", style: AppStyle.txtRobotoRomanBold20,),
                    ),
                    CustomTextFormField2(
                      focusNode: FocusNode(),
                      margin: getMargin(
                        top: 20,
                        left: 30,
                        right: 30,
                      ),
                      controller: null,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.phone,
                      validator: (value) {
                        _orderBloc.eventController.sink.add(InputPhone(phone: value!.toString().trim()));
                        if(value.toString().trim().isEmpty){
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
                      child: Text("Phương thức thanh toán", style: AppStyle.txtRobotoRomanBold20,),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 30
                      ),
                      child: SizedBox(
                        height: getHorizontalSize(70),
                        child: RadioGroup<String>.builder(
                          direction: Axis.horizontal,
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
                          child: Text("Số tiền mua hàng", style: AppStyle.txtRobotoRomanBold20,),

                        ),
                        const Spacer(),
                        Padding(
                          padding: getPadding(
                            top: 30,
                            right: 20,
                          ),
                          child: Text("${totalPrice} VNĐ", style: AppStyle.txtMedium14Black,),

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
                          child: Text("Phí vận chuyển", style: AppStyle.txtRobotoRomanBold20,),

                        ),
                        const Spacer(),
                        Padding(
                          padding: getPadding(
                            top: 30,
                            right: 20,
                          ),
                          child: Text("30.000 VNĐ", style: AppStyle.txtMedium14Black,),

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }
}
