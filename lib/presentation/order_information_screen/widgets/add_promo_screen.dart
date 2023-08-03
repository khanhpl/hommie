// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/widgets/promo_item_in_order.dart';

import '../../../core/models/promo/promo_data.dart';
import '../../../widgets/custom_text_form_field2.dart';

class AddPromoScreen extends StatefulWidget {
  AddPromoScreen(
      {Key? key,
      required this.orderBloc,
      required this.listPromo,
      required this.totalPrice})
      : super(key: key);
  final OrderBloc orderBloc;
  List<PromoData> listPromo;
  double totalPrice;

  @override
  State<AddPromoScreen> createState() => _AddPromoScreenState(
      orderBloc: orderBloc, listPromo: listPromo, totalPrice: totalPrice);
}

class _AddPromoScreenState extends State<AddPromoScreen> {
  _AddPromoScreenState(
      {required this.orderBloc,
      required this.listPromo,
      required this.totalPrice});

  final OrderBloc orderBloc;
  List<PromoData> listPromo;
  double totalPrice;
  List<PromoData> listSearchPromo = [];
  final promoCodeController = TextEditingController();
  String searchPromoValue = "";
  void searchPromo() {
    setState(() {
      searchPromoValue = promoCodeController.text.trim();
      listSearchPromo = [];
      for(PromoData promo in listPromo){
        if(promo.code.contains(searchPromoValue)){
          listSearchPromo.add(promo);
        }
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    promoCodeController.addListener(searchPromo);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: CustomTextFormField2(
            hintText: "Nhập mã",
            // focusNode: FocusNode(),
            controller: promoCodeController,
            width: width,
            margin: getMargin(top: 5),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
            isObscureText: false,
            prefix: Icon(
              Icons.discount,
              color: ColorConstant.primaryColor,
            ),
          ),
        ),
        body: Material(
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: (searchPromoValue.isEmpty) ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(top: 20, left: 20),
                          child: Text(
                            "ƯU ĐÃI DÀNH CHO BẠN",
                            style: AppStyle.txtRobotoRomanMedium14Black,
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(15),
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: getPadding(all: 0),
                          itemBuilder: (context, index) {
                            return promoItemInOrder(
                                context, listPromo[index], orderBloc, totalPrice);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: getVerticalSize(15),
                          ),
                          itemCount: listPromo.length,
                        ),
                      ],
                    ) : (listSearchPromo.isNotEmpty) ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(top: 20, left: 20),
                          child: Text(
                            "ƯU ĐÃI DÀNH CHO BẠN1",
                            style: AppStyle.txtRobotoRomanMedium14Black,
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(15),
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: getPadding(all: 0),
                          itemBuilder: (context, index) {
                            return promoItemInOrder(
                                context, listSearchPromo[index], orderBloc, totalPrice);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: getVerticalSize(15),
                          ),
                          itemCount: listSearchPromo.length,
                        ),
                      ],
                    ) : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(top: 20, left: 20),
                          child: Text(
                            "Không tìm thấy ưu đãi phù hợp",
                            style: AppStyle.txtRobotoRomanMedium14Black,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
