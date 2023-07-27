// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:hive/hive.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/list_item/item_image.dart';
import 'package:hommie/core/models/list_item/list_item_data.dart';
import 'package:hommie/core/models/list_item/detail_item.dart';
import 'package:hommie/presentation/bottom_bar_navigator/bottom_bar_navigator.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_bloc.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_state.dart';
import 'package:hommie/widgets/dialog/login_alert_dialog.dart';
import 'package:hommie/widgets/option_widget.dart';

import '../presentation/cart_screen/cart_bloc/cart_event.dart';
import 'custom_carousel_image2.dart';

class ItemDetailScreen extends StatefulWidget {
  ItemDetailScreen({Key? key, required this.item}) : super(key: key);
  ListItemData item;
  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState(item: item);
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  _ItemDetailScreenState({required this.item});

  List<String> images = [];
  ListItemData item;
  final _cartBloc = CartBloc();
  Detail? selectedItem;
  String sizeString = '';
  String colorString = '';
  String descriptionStr = '';
  var box = Hive.box('hommieBox');
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = (box.get('isLogin') != null) ? box.get('isLogin') : false;
    for(Detail detail in item.details){

      bool isDubSize = false;
      bool isDubColor = false;
      for(String size in sizeString.split(",")){
        if(size.trim() == detail.size.trim()){
          isDubSize = true;
        }
      }
      if(!isDubSize){
        sizeString = "$sizeString${detail.size}, ";
      }
      for(String color in colorString.split(",")){

        if(color.trim() == detail.color.trim()){
          isDubColor = true;
        }
      }
      if(!isDubColor){
        colorString = "$colorString${detail.color}, ";
      }


      for(ItemImage image in detail.itemImages){
        if(!images.contains(image.image)){
          images.add(image.image);
        }
      }
      if(descriptionStr.isEmpty){
        descriptionStr = "-${detail.description}";
      }else{
        descriptionStr = "$descriptionStr\n-${detail.description}";
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Object>(
      stream: _cartBloc.stateController.stream,
      builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data is ReturnItemDetail){
            selectedItem = (snapshot.data as ReturnItemDetail).itemDetail;
          }
        }
        return Scaffold(
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
              child: Text(
                "Thông tin sản phẩm",
                style: AppStyle.txtRobotoRomanBold24,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBarNavigator(selectedIndex: 1, isBottomNav: true),), (route) => false);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  size: getSize(25),
                  color: ColorConstant.primaryColor,
                ),
              ),
            ],
          ),
          floatingActionButton: CustomButton(
            height: getVerticalSize(
              54,
            ),
            text: "Thêm vào giỏ hàng",
            margin: getMargin(
              left: 20,
              top: 18,
              right: 20,
            ),
            onTap: () {
              if(isLogin){
                if(selectedItem != null){
                  if(selectedItem!.quantity >0){
                    _cartBloc.eventController.sink.add(AddToCart(
                        context: context, quantity: 1, itemDetailID: selectedItem!.id));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sản phẩm tạm hết hàng'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng chọn loại trước khi thêm'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }else{
                showLoginAlertDialog(context);
              }
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: Material(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(size.height * 0.02),
                      ),
                      child:  CustomCarouselImage2(images: images),
                    ),

                    Container(
                      width: width,
                      margin: getMargin(top: 15),
                      padding: getPadding(all: 10),
                      color: ColorConstant.whiteA700,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width,
                            child: Text(
                              item.name,
                              style: AppStyle.txtRegular16Black,
                              maxLines: null,
                            ),
                          ),
                          SizedBox(
                            height: getHorizontalSize(5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${MoneyFormatter(amount: (selectedItem != null) ? selectedItem!.price.toDouble() : item.details[0].price.toDouble()).output.withoutFractionDigits} VNĐ",
                                style: AppStyle.txtRobotoRomanMedium16,
                                maxLines: null,
                              ),
                              const Spacer(),
                              Text(
                                "Số lượng: ${selectedItem!= null ? selectedItem!.quantity : ""}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRegular14Bluegray700,
                              ),

                              Text(
                                " | ",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRegular14Bluegray700,
                              ),
                              Text(
                                "${item.buyNumber} lượt mua",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRegular14Bluegray700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      margin: getMargin(top: 15),
                      padding: getPadding(all: 10),
                      color: ColorConstant.whiteA700,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Loại:",
                            style: AppStyle.txtMedium14Black,
                          ),
                          Expanded(
                            child: Container(
                              margin: getMargin(left: 10),
                              height: getVerticalSize(150),
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: getHorizontalSize(
                                      100,
                                    ),
                                    mainAxisExtent: getVerticalSize(
                                      40,
                                    ),
                                    // childAspectRatio: 2 / 3,
                                    crossAxisSpacing: getVerticalSize(20),
                                    mainAxisSpacing: getHorizontalSize(30),
                                  ),
                                  itemCount: item.details.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        _cartBloc.eventController.sink.add(ChooseItemDetail(itemDetail: item.details[index]));
                                      },
                                      child: optionWidget(
                                          context, item.details[index], (selectedItem == null) ? 0 : selectedItem!.id),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      margin: getMargin(top: 15),
                      padding: getPadding(all: 10),
                      color: ColorConstant.whiteA700,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: getHorizontalSize(250),
                                    padding: getPadding(all: 10),
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(getSize(10)),
                                        topRight: Radius.circular(getSize(10)),
                                      ),
                                      color: ColorConstant.whiteA700,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Chi tiết sản phẩm',
                                                  style: AppStyle.txtRegular16Black,
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    top: 20,
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          "Danh mục:",
                                                          style: AppStyle
                                                              .txtRegular16Black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            item.cateName,
                                                            style: AppStyle
                                                                .txtRegular16Black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    top: 20,
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          "Loại sản phẩm:",
                                                          style: AppStyle
                                                              .txtRegular16Black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            item.subName,
                                                            style: AppStyle
                                                                .txtRegular16Black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    top: 20,
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          "Chất liệu:",
                                                          style: AppStyle
                                                              .txtRegular16Black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            item.material,
                                                            style: AppStyle
                                                                .txtRegular16Black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    top: 20,
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          "Kích cỡ:",
                                                          style: AppStyle
                                                              .txtRegular16Black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            sizeString,
                                                            maxLines: null,
                                                            style: AppStyle
                                                                .txtRegular16Black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    top: 20,
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          "Màu sắc:",
                                                          style: AppStyle
                                                              .txtRegular16Black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,

                                                          child: Text(
                                                            colorString,
                                                            maxLines: null,
                                                            style: AppStyle
                                                                .txtRegular16Black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                              size: getSize(25),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Chi tiết sản phầm",
                                  style: AppStyle.txtMedium14Black,
                                ),
                                const Spacer(),
                                Text(
                                  "Chất liệu, màu, ...",
                                  style: AppStyle.txtRegular14Black,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: getSize(15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: getHorizontalSize(0.5),
                      color: ColorConstant.gray400,
                    ),
                    Container(
                      width: width,
                      padding: getPadding(all: 10),
                      color: ColorConstant.whiteA700,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mô tả sản phẩm:",
                            style: AppStyle.txtMedium14Black,
                          ),
                          SizedBox(
                            height: getHorizontalSize(10),
                          ),
                          Text(
                            descriptionStr,
                            style: AppStyle.txtRegular16Black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getVerticalSize(200),),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
