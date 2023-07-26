import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/cancel_order_screen/cancel_order_screen.dart';
import 'package:hommie/presentation/report_screen/report_screen.dart';
Widget customOrderButton(BuildContext context, String orderStatus, int orderID, String orderCode){
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
  } else if(orderStatus == "Hoàn Thành"){
    return CustomButton(
      height: getVerticalSize(
        54,
      ),
      text: "Phản hồi",
      margin: getMargin(
        left: 20,
        top: 18,
        right: 20,
        bottom: 20,
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen(orderCode: orderCode,),));
      },
    );
  }else{
    return const SizedBox();
  }
}