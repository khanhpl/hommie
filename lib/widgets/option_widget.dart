import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/list_item/detail_item.dart';
import 'package:hommie/presentation/cart_screen/cart_bloc/cart_bloc.dart';

StatefulWidget optionWidget(
    BuildContext context, Detail itemDetail,  int selectedItemID) {
  final _cartBloc = CartBloc();
  if(itemDetail.id != selectedItemID){
    return StatefulBuilder(
      builder: (context, setState) => Container(
        padding: getPadding(all: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5),),
          borderRadius: BorderRadius.circular(getSize(10)),
        ),
        alignment: Alignment.center,
        child: Text(
          "${itemDetail.color}-${itemDetail.size}",style: AppStyle.txtRegular14Grey,
        ),
      ),
    );
  }else{
    return StatefulBuilder(
      builder: (context, setState) => Container(
        padding: getPadding(all: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: ColorConstant.primaryColor.withOpacity(0.5),),
          borderRadius: BorderRadius.circular(getSize(10)),
        ),
        alignment: Alignment.center,
        child: Text(
          "${itemDetail.color}-${itemDetail.size}", style: AppStyle.txtRobotoRomanMedium14,
        ),
      ),
    );
  }

}
