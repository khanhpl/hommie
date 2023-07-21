import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/cancel_order_screen/cancel_order_screen.dart';
Widget customOrderButton(BuildContext context, String orderStatus, int orderID){
  if(orderStatus == "Chờ Xử Lý"){
    return CustomButton(
      height: getVerticalSize(
        54,
      ),
      text: "Hủy Đơn",
      margin: getMargin(
        left: 20,
        top: 18,
        right: 20,
        bottom: 20,
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CancelOrderScreen(orderID: orderID),));
      },
    );
  }else{
    return const SizedBox();
  }
}