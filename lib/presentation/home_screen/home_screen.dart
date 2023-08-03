import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:hive/hive.dart';
import 'package:hommie/core/models/list_item/list_item.dart';
import 'package:hommie/presentation/bottom_bar_navigator/bottom_bar_navigator.dart';
import 'package:hommie/presentation/home_screen/bloc/home_bloc.dart';
import 'package:hommie/presentation/home_screen/bloc/home_event.dart';
import 'package:hommie/presentation/home_screen/bloc/home_state.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_bloc.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_event.dart';
import 'package:hommie/presentation/promotion_screen/bloc/promo_state.dart';
import 'package:hommie/presentation/promotion_screen/promotion_screen.dart';
import 'package:hommie/widgets/custom_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';
import '../../core/models/promo/promo_data.dart';
import '../personal_information_screen/personal_bloc/personal_bloc.dart';
import '../personal_information_screen/personal_bloc/personal_event.dart';
import '../promotion_screen/widgets/promotion_item.dart';

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
  final _personalBloc = PersonalBloc();
  ListItem? listItem;
  List<PromoData> listPromo = [];
  var box = Hive.box('hommieBox');
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = (box.get('isLogin') != null) ? box.get('isLogin') : false;
    if (isLogin) {
      _personalBloc.eventController.sink.add(GetUserInfo());
    }
    promoBloc.eventController.sink.add(GetAllPromo());

    _homeBloc.eventController.sink.add(GetAllItems());
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
                    title: Padding(
                      padding: getPadding(right: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "TiemHomie",
                          style: AppStyle.txtRobotoRomanBold24Pr,
                        ),
                      ),
                    ),
                    actions: [
                      PopupMenuButton(
                          icon: Icon(
                            Icons.support_agent_outlined,
                            color: ColorConstant.blueGray700,
                            size: getSize(30),
                          ),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "  0123456789",
                                      style: TextStyle(
                                        fontSize: size.height * 0.022,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.facebook,
                                      color: Colors.blueGrey,
                                    ),
                                    Text(
                                      "  Facebook",
                                      style: TextStyle(
                                        fontSize: size.height * 0.022,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            setState(() async {
                              if (value == 0) {
                                final Uri url = Uri.parse(
                                    'tel://0123456789');
                                if (!await launchUrl(
                                  url,
                                  mode:
                                  LaunchMode.externalNonBrowserApplication,
                                )) {
                                  throw Exception('Could not launch $url');
                                }

                              } else if (value == 1) {
                                final Uri url = Uri.parse(
                                    'https://www.facebook.com/tiemhomie.sg/');
                                if (!await launchUrl(
                                  url,
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                )) {
                                  throw Exception('Could not launch $url');
                                }
                              }
                            });
                          })
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
                          StreamBuilder<Object>(
                              stream: promoBloc.stateController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data is ReturnAllPromo) {
                                    listPromo =
                                        (snapshot.data as ReturnAllPromo)
                                            .listPromo;
                                  }
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (listPromo.isNotEmpty) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            top: 22,
                                            left: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Mã giảm giá",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtRobotoRomanBold24,
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: getPadding(right: 20),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PromotionScreen(
                                                                  listPromo:
                                                                      listPromo),
                                                        ));
                                                  },
                                                  child: Text(
                                                    "Xem tất cả >",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRomanMedium16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(120),
                                          width: width,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              padding: const EdgeInsets.all(0),
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return SizedBox(
                                                    width: width,
                                                    child: promotionItem(
                                                        context,
                                                        listPromo[index]));
                                              },
                                              separatorBuilder: (context,
                                                      index) =>
                                                  SizedBox(
                                                    width: size.width * 0.03,
                                                  ),
                                              itemCount: (listPromo.length <= 4)
                                                  ? listPromo.length
                                                  : 4),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            top: 22,
                                            left: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Mã giảm giá",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtRobotoRomanBold24,
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: getPadding(right: 20),
                                                child: Text(
                                                  "Xem tất cả >",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanMedium16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width,
                                          margin: getPadding(
                                            left: 40,
                                            top: 15,
                                            right: 40,
                                          ),
                                          padding: getPadding(all: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                getSize(10)),
                                            border: Border.all(
                                                width: 1,
                                                color:
                                                    ColorConstant.primaryColor),
                                          ),
                                          child: Text(
                                            "Hiện không có mã giảm giá khả dụng",
                                            style: AppStyle.txtMedium14BlackPr,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                } else {
                                  return Container(
                                    width: width,
                                    height: getVerticalSize(100),
                                    alignment: Alignment.center,
                                    child:
                                        LoadingAnimationWidget.discreteCircle(
                                            color: ColorConstant.primaryColor,
                                            size: getSize(50)),
                                  );
                                }
                              }),
                          Padding(
                            padding: getPadding(
                              top: 22,
                              left: 10,
                            ),
                            child: Text(
                              "Sản phẩm hiện có",
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
                                    250,
                                  ),
                                  // childAspectRatio: 2 / 3,
                                  crossAxisSpacing: getVerticalSize(20),
                                  mainAxisSpacing: getHorizontalSize(10),
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
