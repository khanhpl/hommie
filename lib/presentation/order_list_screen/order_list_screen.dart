import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/order_list_screen/widget/pending_widget.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        indicatorColor: ColorConstant.primaryColor,
        labelPadding: const EdgeInsets.all(10),
        tabs: [
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Chờ xử lý",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Đang đóng gói",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Đang vận chuyển",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Đã Tới nơi",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
        isScrollable: true,
      );
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Đơn hàng của bạn",
            ),
          ),
          titleTextStyle: TextStyle(
            fontSize: size.height * 0.028,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bottom: createTabBar(),
        ),
        body: Material(
          child: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                Material(
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
                          const PendingPanel(),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
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
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
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
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
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
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
