import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/promo/promo_data.dart';

// ignore: must_be_immutable
class PromotionDetailScreen extends StatefulWidget {
  PromotionDetailScreen({Key? key, required this.promo}) : super(key: key);
  PromoData promo;

  @override
  State<PromotionDetailScreen> createState() =>
      // ignore: no_logic_in_create_state
      _PromotionDetailScreenState(promo: promo);
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen> {
  _PromotionDetailScreenState({required this.promo});

  PromoData promo;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            size: size.height * 0.03,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Material(
        color: Colors.white,
        child: Container(
          alignment: Alignment.topCenter,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.03,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
                  height: size.height * 0.7,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          ImageConstant.couponDetail,
                        ),
                        fit: BoxFit.fill),
                  ),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.43,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: size.width*0.05, right: size.width*0.03),
                                  width: size.width * 0.15,
                                  height: size.width * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(promo.image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width*0.03,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          promo.title,
                                          style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Mã KM: ${promo.code}",
                                          style: TextStyle(
                                            fontSize: size.height * 0.018,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SizedBox(
                              width: size.width * 0.75,
                              child: Text(
                                "Đối tượng áp dụng: tất cả các khách hàng đã đăng ký tài khoản",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  height: size.height * 0.002,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SizedBox(
                              width: size.width * 0.75,
                              child: Text(
                                promo.description,
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  height: size.height * 0.002,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            SizedBox(
                              width: size.width * 0.75,
                              child: Text(
                                "Số lần sử dụng: 1 lần cho mỗi tài khoản",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  height: size.height * 0.002,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.12,
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: size.height * 0.07,
                        ),
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage(
                        //       ImageConstant.imgFrame,
                        //     ),
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width * 0.75,
                              child: Text(
                                "Số lượng mã phát hành: ${promo.quantity}",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  height: size.height * 0.002,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.75,
                              child: Text(
                                "Thời gian áp dụng từ ${promo.dateStart.format()} đến ${promo.dateExp.format()}",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  height: size.height * 0.002,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  height: getVerticalSize(
                    54,
                  ),
                  text: "Sao chép mã",
                  margin: getMargin(
                    left: 20,
                    top: 18,
                    right: 20,
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: promo.code));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
