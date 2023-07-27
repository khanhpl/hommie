import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/promo/promo_data.dart';
import 'package:hommie/presentation/promotion_screen/widgets/promotion_detail_screen.dart';

Widget promotionItem(BuildContext context, PromoData promo) {
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
      height: size.height * 0.15,
      margin: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.coupon,
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
            width: size.width * 0.12,
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
            width: size.width * 0.12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width*0.5,
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
              Text(
                "Hạn sử dụng đến ngày ${promo.dateExp.toString().split(" ")[0]}",
                style: TextStyle(
                  fontSize: size.height * 0.014,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
