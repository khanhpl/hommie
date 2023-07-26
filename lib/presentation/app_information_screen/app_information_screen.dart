import 'package:hommie/core/app_export.dart';
class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
          child: Padding(
            padding: getPadding(right: 45),
            child: Text(
              "Thông tin ứng dụng",
              style: AppStyle.txtRobotoRomanBold24,
            ),
          ),
        ),
      ),
      body: Material(
        child: Container(
          color: Colors.white,
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phiên bản: 1.1.0", style: AppStyle.txtRegular16Black,),
              InkWell(
                  onLongPress: (){
                    Clipboard.setData(const ClipboardData(text: "0968535067"));
                  },
                  child: Text("Hotline: 0968535067", style: AppStyle.txtRegular16Black,)),
            ],
          ),
        ),
      ),
    );
  }
}
