import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:hommie/core/models/list_item/list_item.dart';
import 'package:hommie/presentation/home_screen/bloc/home_bloc.dart';
import 'package:hommie/presentation/home_screen/bloc/home_event.dart';
import 'package:hommie/presentation/home_screen/bloc/home_state.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_bloc.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_event.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_state.dart';
import 'package:hommie/presentation/promotion_screen/promotion_screen.dart';
import 'package:hommie/widgets/custom_item.dart';

import '../../core/app_export.dart';
import '../../core/models/promo/promo_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map> myProducts =
      List.generate(4, (index) => {"id": index, "name": "Product $index"})
          .toList();
  final _homeBloc = HomeBloc();
  final promoBloc = PromoBloc();
  ListItem? listItem;
  List<PromoData> listPromo = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBloc.eventController.sink.add(GetAllItems());
    promoBloc.eventController.sink.add(GetAllPromo());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<Object>(
            stream: _homeBloc.stateController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data is ReturnLatestItems) {
                  listItem = (snapshot.data as ReturnLatestItems).listItem;
                }
              } else {}
              return Scaffold(
                appBar: CustomAppBar(
                    height: getVerticalSize(60),
                    leadingWidth: 45,
                    leading: AppbarImage(
                        height: getSize(60),
                        width: getSize(60),
                        imagePath: ImageConstant.imgFrame,
                        margin: getMargin(left: 19, top: 8, bottom: 7)),
                    title: AppbarImage(
                        height: getVerticalSize(41),
                        width: getHorizontalSize(100),
                        imagePath: ImageConstant.imgDecorShopPm,
                        margin: getMargin(left: 80)),
                    actions: [
                      Container(
                          height: getVerticalSize(28.96),
                          width: getHorizontalSize(29.540009),
                          margin: getMargin(left: 17, top: 5, right: 23),
                          child:
                              Stack(alignment: Alignment.topRight, children: [
                            AppbarImage(
                                height: getVerticalSize(26),
                                width: getHorizontalSize(27),
                                svgPath: ImageConstant.imgCart,
                                margin: getMargin(top: 10, right: 2),
                                onTap: () {}),
                            Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    width: getHorizontalSize(16),
                                    margin: getMargin(left: 13, bottom: 13),
                                    padding: getPadding(
                                        left: 5, top: 1, right: 5, bottom: 1),
                                    child: Text("2",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtRobotoBold9)))
                          ]))
                    ]),
                body: Material(
                  child: Container(
                    color: Colors.white,
                    width: width,
                    height: height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                getMarginOrPadding(left: 8, right: 8, top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.02),
                            ),
                            child: const CustomCarouselImage(),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 22,
                              left: 10,
                            ),
                            child: Text(
                              "Khuyến mãi",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoRomanBold24,
                            ),
                          ),
                          StreamBuilder<Object>(
                              stream: promoBloc.stateController.stream,
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  if(snapshot.data is ReturnAllPromo){
                                    listPromo = (snapshot.data as ReturnAllPromo).listPromo;
                                  }
                                }
                                if(listPromo.isEmpty){
                                  return Container(
                                    width: width,
                                    margin: getMarginOrPadding(
                                      top: 15,
                                      left: 22,
                                      right: 22,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          size.height * 0.005),
                                      border: Border.all(
                                        width: 1,
                                        color: ColorConstant.primaryColor
                                            .withOpacity(0.5),
                                      ),
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.07),
                                            child: Text(
                                              "Bạn đang có 0 ưu đãi",
                                              style:
                                              AppStyle.txtRobotoRomanMedium14,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: DottedDecoration(
                                              color: ColorConstant.primaryColor,
                                              strokeWidth: 0.5,
                                              linePosition: LinePosition.left,
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                left: size.width * 0.05,
                                                right: size.width * 0.05,
                                                top: size.height * 0.01,
                                                bottom: size.height * 0.01,
                                              ),
                                              margin: EdgeInsets.only(
                                                top: size.height * 0.01,
                                                bottom: size.height * 0.01,
                                                left: size.width * 0.03,
                                                right: size.width * 0.03,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorConstant.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    size.height * 0.005),
                                              ),
                                              child: Text("Xem",
                                                  style:
                                                  AppStyle.txtMedium14White),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }else{
                                  return Container(
                                    width: width,
                                    margin: getMarginOrPadding(
                                      top: 15,
                                      left: 22,
                                      right: 22,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          size.height * 0.005),
                                      border: Border.all(
                                        width: 1,
                                        color: ColorConstant.primaryColor
                                            .withOpacity(0.5),
                                      ),
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.07),
                                            child: Text(
                                              "Bạn đang có ${listPromo.length} ưu đãi",
                                              style:
                                              AppStyle.txtRobotoRomanMedium14,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => PromotionScreen(listPromo: listPromo),));
                                          },
                                          child: Container(
                                            decoration: DottedDecoration(
                                              color: ColorConstant.primaryColor,
                                              strokeWidth: 0.5,
                                              linePosition: LinePosition.left,
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                left: size.width * 0.05,
                                                right: size.width * 0.05,
                                                top: size.height * 0.01,
                                                bottom: size.height * 0.01,
                                              ),
                                              margin: EdgeInsets.only(
                                                top: size.height * 0.01,
                                                bottom: size.height * 0.01,
                                                left: size.width * 0.03,
                                                right: size.width * 0.03,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorConstant.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    size.height * 0.005),
                                              ),
                                              child: Text("Xem",
                                                  style:
                                                  AppStyle.txtMedium14White),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                          Padding(
                            padding: getPadding(
                              top: 22,
                              left: 10,
                            ),
                            child: Text(
                              "Sản phẩm mới",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoRomanBold24,
                            ),
                          ),
                          Container(
                            height: getVerticalSize(498),
                            padding: getPadding(left: 20, right: 20),
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: getHorizontalSize(
                                    160,
                                  ),
                                  mainAxisExtent: getVerticalSize(
                                    226,
                                  ),
                                  // childAspectRatio: 2 / 3,
                                  crossAxisSpacing: getVerticalSize(20),
                                  mainAxisSpacing: getHorizontalSize(30),
                                ),
                                itemCount: (listItem != null)
                                    ? ((listItem!.data.length < 4)
                                        ? listItem!.data.length
                                        : 4)
                                    : 0,
                                itemBuilder: (BuildContext ctx, index) {
                                  return CustomItem(
                                    item: listItem!.data[index],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: getHorizontalSize(100),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
