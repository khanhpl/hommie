import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/order/order.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_bloc.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_event.dart';
import 'package:hommie/presentation/order_information_screen/order_bloc/order_state.dart';

import 'order_list_item_widget.dart';

class PendingPanel extends StatefulWidget {
  const PendingPanel({Key? key}) : super(key: key);

  @override
  State<PendingPanel> createState() => _PaidHistoryPanelState();
}

class _PaidHistoryPanelState extends State<PendingPanel> {
  final _orderBloc = OrderBloc();
  Order? order;

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
              order = (snapshot.data as ReturnAllOrder).order;
            }
          }
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
                    (order == null)
                        ? const SizedBox()
                        : ListView.separated(
                            padding: const EdgeInsets.all(0),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {},
                              child: orderListItemWidget(context, order!.data[index]),
                            ),
                            separatorBuilder: (context, index) => Container(
                              width: size.width,
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.02),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            itemCount: order!.result,
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
