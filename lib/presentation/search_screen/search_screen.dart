import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/categories/categories.dart';
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
  SubCategories? subCategories;
  String rsMsg = "";
  ListItem? listItem;
  int? spValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchBloc.eventController.sink.add(GetAllCate());
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: StreamBuilder(
        stream: _searchBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ReturnAllCate) {
              categories = (snapshot.data as ReturnAllCate).categories;
              subCategories = null;
              spValue = null;
              _searchBloc.eventController.sink.add(OtherSearchEvent());
            }
            if (snapshot.data is ReturnSubCategories) {
              subCategories =
                  (snapshot.data as ReturnSubCategories).subCategories;
              _searchBloc.eventController.sink.add(OtherSearchEvent());
            }
            if (snapshot.data is SearchResult) {
              listItem = (snapshot.data as SearchResult).listItem;
            }
          }
          return Material(
            child: Container(
              color: ColorConstant.whiteA700,
              width: width,
              height: height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                            controller: null,
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
                                        .add(Search());
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
                    Row(
                      children: [
                        SizedBox(
                          width: getHorizontalSize(185),
                          child: Padding(
                            padding: getPadding(
                              top: 20,
                              left: 20,
                              bottom: 20,
                            ),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: size.width * 0.015,
                                  right: size.width * 0.015,
                                ),
                                filled: true,
                                fillColor:
                                    ColorConstant.primaryColor.withOpacity(0.2),
                                labelStyle: AppStyle.txtMedium14Black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                              ),
                              hint: Text(
                                'Danh mục',
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.txtMedium14Black,
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                              ),
                              iconSize: size.width * 0.05,
                              buttonHeight: size.height * 0.07,
                              buttonPadding: const EdgeInsets.all(0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: (categories != null)
                                  ? categories!.data
                                      .map(
                                        (item) => DropdownMenuItem<int>(
                                          value: item.id,
                                          child: SizedBox(
                                            width: getHorizontalSize(90),
                                            child: Text(
                                              item.name,
                                              style: AppStyle.txtMedium14Black,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  spValue = null;
                                  subCategories = null;
                                  _searchBloc.eventController.sink
                                      .add(ChooseCate(cateID: value!));
                                });
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: getHorizontalSize(185),
                          child: Padding(
                            padding: getPadding(
                              top: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: size.width * 0.015,
                                  right: size.width * 0.015,
                                ),
                                filled: true,
                                fillColor:
                                    ColorConstant.primaryColor.withOpacity(0.2),
                                labelStyle: AppStyle.txtMedium14Black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                              ),
                              hint: Text(
                                'Loại sp',
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.txtMedium14Black,
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                              ),
                              iconSize: size.width * 0.05,
                              buttonHeight: size.height * 0.07,
                              buttonPadding: const EdgeInsets.all(0),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              value: (spValue != null) ? spValue : null,
                              items: (subCategories != null)
                                  ? subCategories!.data
                                      .map(
                                        (item) => DropdownMenuItem<int>(
                                          value: item.id,
                                          child: SizedBox(
                                            width: getHorizontalSize(90),
                                            child: Text(
                                              item.name,
                                              style: AppStyle.txtMedium14Black,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()
                                  : null,
                              onChanged: (value) {
                                _searchBloc.eventController.sink
                                    .add(ChooseSubCate(subCateID: value!));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    (listItem != null)
                        ? (listItem!.data.isNotEmpty)
                            ? Container(
                                padding: getPadding(left: 20, right: 20),
                                width: width,
                                height: getHorizontalSize(500),
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
                                        avgRating: ((listItem!.data[index]
                                                    .details[0].rate !=
                                                null)
                                            ? listItem!
                                                .data[index].details[0].rate
                                            : 0),
                                        imgLink: listItem!
                                            .data[index].imageList[0].image,
                                        name: listItem!.data[index].name,
                                        price: listItem!
                                            .data[index].details[0].price,
                                        type:
                                            "${listItem!.data[index].cateName}/${listItem!.data[index].subName}",
                                        itemDetailID: listItem!.data[index].details[0].id,
                                      );
                                    }),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
