import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/history_screen/widgets/canceled_panel.dart';
import 'package:hommie/presentation/history_screen/widgets/completed_panel.dart';
import 'package:hommie/presentation/order_list_screen/widget/on_boxing_widget.dart';
import 'package:hommie/presentation/order_list_screen/widget/on_shipping_panel.dart';
import 'package:hommie/presentation/order_list_screen/widget/pending_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
              "Hoàn Thành",
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
              "Đã Hủy",
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: getVerticalSize(60),
          leadingWidth: 45,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: getPadding(right: 45),
              child: Text(
                "Lịch Sử",
                style: AppStyle.txtRobotoRomanBold24,
              ),
            ),
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
                          const CompletedPanel(),
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
                          const CanceledPanel(),
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
