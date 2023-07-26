// ignore_for_file: no_logic_in_create_state

// ignore_for_file: must_be_immutable

import 'package:group_radio_button/group_radio_button.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/report_screen/bloc/report_bloc.dart';
import 'package:hommie/presentation/report_screen/widgets/showConfirmReportDialog.dart';

import '../../widgets/custom_text_form_field2.dart';
import '../cancel_order_screen/widgets/confirm_cancel_dialog.dart';
class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key, required this.orderCode}) : super(key: key);
  String orderCode;
  @override
  State<ReportScreen> createState() => _ReportScreenState(orderCode: orderCode);
}

class _ReportScreenState extends State<ReportScreen> {
  _ReportScreenState({required this.orderCode});
  String orderCode;
  final reportBloc = ReportBloc();
  List<String> cancelReason = ["Thời gian giao hàng quá lâu",
    "Giao nhầm loại sản phẩm",
    "Sản phẩm không giống mô tả",
    "Khác"];
  String groupValue = "Khác";
  final noteController = TextEditingController();
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
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: getPadding(right: 45),
            child: Text(
              "Phản hồi",
              style: AppStyle.txtRobotoRomanBold36,
            ),
          ),
        ),

      ),
      floatingActionButton: CustomButton(
        height: getVerticalSize(
          54,
        ),
        text: "Xác nhận",
        margin: getMargin(
          left: 20,
          top: 18,
          right: 20,
        ),
        onTap: (){
          String content = "$groupValue - ${noteController.text}";
          showConfirmReportDialog(context, orderCode, content);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Material(
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  child: RadioGroup<String>.builder(
                    direction: Axis.vertical,
                    groupValue: groupValue,
                    horizontalAlignment: MainAxisAlignment.spaceAround,
                    onChanged: (value) => setState(() {
                      groupValue = value ?? '';
                    }),
                    items: cancelReason,
                    textStyle: TextStyle(
                      fontSize: getSize(15),
                      color: Colors.black,
                    ),
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
                ),
                CustomTextFormField2(
                  hintText: "Ghi chú",
                  focusNode: FocusNode(),
                  controller: noteController,
                  width: width,
                  maxLines: 3,
                  margin: getMargin(
                    left: 10,
                    // top: 25,
                    right: 10,
                  ),
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                  isObscureText: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
