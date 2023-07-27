import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hive/hive.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/categories/categories.dart';
import 'package:hommie/core/models/categories/category.dart';
import 'package:hommie/core/models/sub_categories/sub_category.dart';
import 'package:hommie/core/models/list_item/list_item.dart';
import 'package:hommie/core/models/sub_categories/sub_categories.dart';
import 'package:hommie/presentation/search_screen/bloc/search_bloc.dart';
import 'package:hommie/presentation/search_screen/bloc/search_event.dart';
import 'package:hommie/widgets/custom_text_form_field2.dart';
import '../../widgets/custom_item.dart';
import 'bloc/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchBloc = SearchBloc();
  Categories? categories;
  List<SubCategories> listSubCate = [];
  ListItem? listItem;
  Category? selectedCate;
  SubCategory? selectedSubCate;
  final searchValueController = TextEditingController();
  var box = Hive.box('hommieBox');
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchBloc.eventController.sink.add(GetAllCate());
    isLogin = (box.get('isLogin') != null) ? box.get('isLogin') : false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _searchBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ReturnAllCate) {
              categories = null;
              categories = Categories(
                  data: [Category(id: -1, name: "Tất cả")], result: 1);
              categories!.result =
                  (snapshot.data as ReturnAllCate).categories.data.length + 1;
              for (Category cate
                  in (snapshot.data as ReturnAllCate).categories.data) {
                categories!.data.add(cate);
              }
              for (Category cate in categories!.data) {
                _searchBloc.eventController.sink
                    .add(GetSubCateByCateID(cateID: cate.id));
              }
            }
            if (snapshot.data is ReturnSubCategories) {
              SubCategories subCategories = SubCategories(data: [
                SubCategory(id: -1, name: "Tất cả", status: "", cateId: -1)
              ], result: 1);
              subCategories.result = (snapshot.data as ReturnSubCategories)
                  .subCategories
                  .data
                  .length;
              for (SubCategory subCate
                  in ((snapshot.data as ReturnSubCategories)
                      .subCategories
                      .data)) {
                subCategories.data.add(subCate);
              }
              listSubCate.add(subCategories);
            }
            if (snapshot.data is SearchResult) {
              listItem = (snapshot.data as SearchResult).listItem;
            }
            if (snapshot.data is ReturnSelectedCate) {
              selectedCate = (snapshot.data as ReturnSelectedCate).cate;
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
              title: AppbarImage(
                  height: getVerticalSize(41),
                  width: getHorizontalSize(100),
                  imagePath: ImageConstant.imgDecorShopPm,
                  margin: getMargin(left: 90)),
              actions: [
                Padding(
                  padding: getPadding(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (context, setState) {
                              return AlertDialog(
                                title: Text(
                                  'Danh mục',
                                  style: AppStyle.txtRobotoRomanBold24,
                                ),
                                content: Material(
                                  child: Container(
                                    width: width,
                                    height: getVerticalSize(400),
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (categories != null)
                                              ? SizedBox(
                                                  child: RadioGroup<
                                                      Category?>.builder(
                                                    direction: Axis.vertical,
                                                    groupValue:
                                                        (selectedCate != null)
                                                            ? selectedCate
                                                            : null,
                                                    horizontalAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      _searchBloc
                                                          .eventController.sink
                                                          .add(ChooseCate(
                                                              cate: value!));

                                                      Navigator.pop(context);
                                                      if (value.name ==
                                                          "Tất cả") {
                                                        // subCategories = null;
                                                        selectedSubCate = null;
                                                      } else {
                                                        if (listSubCate
                                                            .where((element) {
                                                              if (element.data
                                                                      .length >
                                                                  1) {
                                                                if (element
                                                                        .data[1]
                                                                        .cateId ==
                                                                    value.id) {
                                                                  return true;
                                                                } else {
                                                                  return false;
                                                                }
                                                              } else {
                                                                return false;
                                                              }
                                                            })
                                                            .toList()
                                                            .isNotEmpty) {
                                                          SubCategories
                                                              subCateDialogData =
                                                              listSubCate.where(
                                                                  (element) {
                                                            if (element
                                                                    .data.length >
                                                                1) {
                                                              if (element.data[1]
                                                                      .cateId ==
                                                                  value.id) {
                                                                return true;
                                                              } else {
                                                                return false;
                                                              }
                                                            } else {
                                                              return false;
                                                            }
                                                          }).toList()[0];
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  'Loại sản phẩm',
                                                                  style: AppStyle
                                                                      .txtRobotoRomanBold24,
                                                                ),
                                                                content:
                                                                    StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                    return Material(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            width,
                                                                        height:
                                                                            getVerticalSize(
                                                                                400),
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                child: RadioGroup<SubCategory?>.builder(
                                                                                  direction: Axis.vertical,
                                                                                  groupValue: (selectedSubCate != null) ? selectedSubCate : null,
                                                                                  horizontalAlignment: MainAxisAlignment.spaceAround,
                                                                                  onChanged: (value) => setState(() {
                                                                                    selectedSubCate = value;
                                                                                    _searchBloc.eventController.sink.add(ChooseSubCate(subCate: value!));
                                                                                    Navigator.pop(context);
                                                                                  }),
                                                                                  items: subCateDialogData.data,
                                                                                  textStyle: TextStyle(
                                                                                    fontSize: getSize(15),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  itemBuilder: (item) => RadioButtonBuilder(
                                                                                    item!.name,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          print('ko có data');
                                                        }
                                                      }
                                                    }),
                                                    items: categories!.data,
                                                    textStyle: TextStyle(
                                                      fontSize: getSize(15),
                                                      color: Colors.black,
                                                    ),
                                                    itemBuilder: (item) =>
                                                        RadioButtonBuilder(
                                                      item!.name,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      });
                    },
                    child: Icon(
                      Icons.filter_alt_sharp,
                      color: ColorConstant.primaryColor,
                      size: getSize(30),
                    ),
                  ),
                ),
              ],
            ),
            body: Material(
              child: Container(
                color: ColorConstant.whiteA700,
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextFormField2(
                            hintText: "Tìm kiếm",
                            focusNode: FocusNode(),
                            controller: searchValueController,
                            width: 250,
                            margin: getMargin(
                              left: 20,
                              // top: 25,
                              right: 10,
                            ),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            isObscureText: false,
                            prefix: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: getPadding(right: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(getSize(10))),
                                  ),
                                  onPressed: () {
                                    _searchBloc.eventController.sink
                                        .add(Search(searchValue: searchValueController.text.trim()));
                                  },
                                  child: Text(
                                    "Tìm kiếm",
                                    style: AppStyle.txtMedium14White,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (selectedCate == null)
                        ? const SizedBox()
                        : Padding(
                            padding: getPadding(
                              top: 15,
                              left: 22,
                              right: 22,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    right: 15,
                                  ),
                                  child: Text(
                                    "Lọc:",
                                    style: AppStyle.txtRegular16Black,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${selectedCate!.name.toString()} -> ${(selectedSubCate != null) ? selectedSubCate!.name.toString() : "Tất cả"}",
                                    style: AppStyle.txtRobotoRomanMedium16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                    SizedBox(height: getVerticalSize(15),),
                    (listItem != null)
                        ? (listItem!.data.isNotEmpty)
                            ? Expanded(
                                child: Padding(
                                  padding: getPadding(left: 20, right: 20, bottom: 15),
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
                                          ? listItem!.data.length
                                          : 0,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return CustomItem(
                                          item: listItem!.data[index],
                                        );
                                      }),
                                ),
                              )
                            : const Text("Chưa có sản phẩm")
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
