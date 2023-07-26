import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/order/list_item.dart';

Widget itemInOrderList(BuildContext context, ListItem item) {
  return Material(
    child: Container(
      width: width,
      padding: getPadding(
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            width: 0.5,
            color: Colors.grey.withOpacity(0.5),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: getHorizontalSize(50),
            height: getHorizontalSize(50),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(item.itemImage), fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Padding(
              padding: getPadding(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName,
                    style: AppStyle.txtRegular14Black,
                  ),
                  SizedBox(
                    height: getVerticalSize(5),
                  ),
                  Row(
                    children: [
                      Text(
                        "${item.material}-${item.size}",
                        style: AppStyle.txtRegular14Grey,
                      ),
                      const Spacer(),
                      Text(
                        "x${item.orderQuantity}",
                        style: AppStyle.txtRegular14Black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getVerticalSize(5),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        "Thành tiền: ${MoneyFormatter(amount: item.price).output.withoutFractionDigits} VNĐ",
                        style: AppStyle.txtRegular14Black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
