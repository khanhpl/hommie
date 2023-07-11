import 'package:hommie/core/app_export.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../../core/models/order/Datum.dart';


Widget orderListItemWidget(BuildContext context, Datum data) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 4.0,
    ),
    padding: EdgeInsets.all(size.height * 0.01),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.grey.withOpacity(0.4),
      ),
      borderRadius: BorderRadius.circular(size.height * 0.02),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.list, size: size.height*0.05,),
            SizedBox(
              width: size.width * 0.03,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mã đơn hàng: ${data.orderCode}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tổng giá: ",
                        maxLines: null,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${MoneyFormatter(amount: data.totalPrice).output.withoutFractionDigits} VNĐ",
                        maxLines: null,
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Trạng thái: ${data.orderStatus}",
                        maxLines: null,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
