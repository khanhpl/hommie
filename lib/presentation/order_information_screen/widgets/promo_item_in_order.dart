import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/promo/promo_data.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_event.dart';
import 'package:hommie/presentation/promotion_screen/widgets/promotion_detail_screen.dart';

Widget promoItemInOrder(
    BuildContext context, PromoData promo, OrderBloc orderBloc, double totalPrice) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PromotionDetailScreen(promo: promo),
          ));
    },
    child: Container(
      width: size.width,
      height: size.height * 0.1,
      margin: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.selectedPromo,
          ),
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.05,
          ),
          Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(promo.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.48,
                child: Text(
                  promo.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                promo.code,
                style: TextStyle(
                  fontSize: size.height * 0.018,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: size.width * 0.48,
                child: Text(
                  "Hạn sử dụng đến ngày ${promo.dateExp.toString().split(" ")[0]}",
                  style: TextStyle(
                    fontSize: size.height * 0.014,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TextButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getSize(10))),
              ),
              onPressed: () {
                if(totalPrice < promo.minValueOrder){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đơn hàng chưa đạt giá trị tối thiểu'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }else{
                  orderBloc.eventController.sink.add(ChoosePromo(promo: promo));
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Chọn",
                style: AppStyle.txtRobotoRomanMedium14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
