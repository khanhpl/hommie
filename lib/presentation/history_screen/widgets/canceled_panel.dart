import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_event.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_state.dart';

import '../../../core/models/order/order_data.dart';
import '../../order_list_screen/widget/order_list_item_widget.dart';

class CanceledPanel extends StatefulWidget {
  const CanceledPanel({Key? key}) : super(key: key);

  @override
  State<CanceledPanel> createState() => _PaidHistoryPanelState();
}

class _PaidHistoryPanelState extends State<CanceledPanel> {
  final _orderBloc = OrderBloc();
  List<OrderData> listOrder = [];
  @override
  void initState() {
    super.initState();
    _orderBloc.eventController.sink.add(GetAllOrder());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _orderBloc.stateController.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data is ReturnAllOrder){
              listOrder = [];
              for(OrderData order in (snapshot.data as ReturnAllOrder).order.data){
                if(order.orderStatus == "Hủy Đơn Hàng"){
                  listOrder.add(order);
                }
              }
            }
          }

          if (snapshot.connectionState == ConnectionState.active) {
            return Material(
              child: Container(
                color: Colors.white,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      (listOrder.isEmpty)
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: getHorizontalSize(300),
                            height: getVerticalSize(300),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  AssetImage(ImageConstant.imgNoData),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Text("Chưa có đơn hàng ở trạng thái này", style: AppStyle.txtRegular16Black,),
                        ],
                      )
                          : ListView.separated(
                        padding: const EdgeInsets.all(0),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {},
                          child: orderListItemWidget(context, listOrder[index]),
                        ),
                        separatorBuilder: (context, index) => Container(
                          width: size.width,
                          margin:
                          EdgeInsets.only(bottom: size.height * 0.02),
                          color: Colors.black.withOpacity(0.1),
                        ),
                        itemCount: listOrder.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: ColorConstant.primaryColor, size: getSize(50)),
            );
          }
        });
  }
}
