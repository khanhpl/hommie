// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/list_item/data.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_bloc.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_state.dart';
import 'package:hommie/widgets/option_widget.dart';

import '../presentation/cart_screen/cart_bloc/cart_event.dart';

class ItemDetailScreen extends StatefulWidget {
  ItemDetailScreen({Key? key, required this.item}) : super(key: key);
  Data item;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState(item: item);
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  _ItemDetailScreenState({required this.item});

  Data item;
  final _cartBloc = CartBloc();
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _cartBloc.stateController.stream,
      builder: (context, snapshot) {
        print('Test data: ${snapshot.toString()}');
          if(snapshot.hasData){
          print('Có vô luôn');
            if(snapshot.data is ReturnItemDetail){
            selectedItem = (snapshot.data as ReturnItemDetail).itemDetailID;
            print('Test id: ${selectedItem}');
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
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  size: getSize(10),
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
              if(selectedItem != 0){
                _cartBloc.eventController.sink.add(AddToCart(
                    context: context, quantity: 1, itemDetailID: selectedItem));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vui lòng chọn loại trước khi thêm'),
                    duration: Duration(seconds: 2),
                  ),
                );
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
                      margin: getMargin(top: 10),
                      width: width,
                      height: getHorizontalSize(250),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item.imageList[0].image),
                          fit: BoxFit.fill,
                        ),
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
                                "${MoneyFormatter(amount: item.details[0].price).output.withoutFractionDigits} VNĐ",
                                style: AppStyle.txtRobotoRomanMedium16,
                                maxLines: null,
                              ),
                              const Spacer(),
                              Text(
                                "0",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRegular14Bluegray700,
                              ),
                              CustomImageView(
                                svgPath: ImageConstant.imgAtomoestrellaactiva,
                                height: getVerticalSize(
                                  15,
                                ),
                                width: getHorizontalSize(
                                  16,
                                ),
                              ),
                              Text(
                                " | ",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRegular14Bluegray700,
                              ),
                              Text(
                                "0 lượt mua",
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
                                        _cartBloc.eventController.sink.add(ChooseItemDetail(itemDetailID: item.details[index].id));
                                      },
                                      child: optionWidget(
                                          context, item.details[index], selectedItem),
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
                                                            item.details[0].size,
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
                                                            item.details[0].color,
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
                            item.details[0].description,
                            style: AppStyle.txtRegular16Black,
                          ),
                        ],
                      ),
                    ),
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
