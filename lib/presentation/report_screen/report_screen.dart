// ignore_for_file: no_logic_in_create_state

// ignore_for_file: must_be_immutable
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/report_screen/bloc/report_bloc.dart';
import 'package:hommie/presentation/report_screen/widgets/showConfirmReportDialog.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/custom_text_form_field2.dart';

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
  List<String> cancelReason = [
    "Thời gian giao hàng quá lâu",
    "Giao nhầm loại sản phẩm",
    "Sản phẩm không giống mô tả",
    "Khác"
  ];
  String groupValue = "Khác";
  final noteController = TextEditingController();
  String reportImage = "";
  late File imageFileReport;
  XFile? pickedFileReport;
  UploadTask? uploadTaskReport;
  bool isAddReportImg = false;

  _getReportImageFromGallery() async {
    pickedFileReport = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileReport != null) {
      setState(() {
        imageFileReport = File(pickedFileReport!.path);
      });
    }
    isAddReportImg = true;
    final path =
        'images/${pickedFileReport!.name}';
    final file = File(pickedFileReport!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskReport = ref.putFile(file);

    final snapshot = await uploadTaskReport!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    reportImage = urlDownload;
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
        onTap: () {
          String content = "$groupValue - ${noteController.text}";
          showConfirmReportDialog(context, orderCode, content, reportImage);
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
                Padding(
                  padding: getPadding(
                    left: 20,
                    bottom: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(getSize(20))),
                        ),
                        onPressed: () {

                          _getReportImageFromGallery();
                        },
                        child: Text(
                          "Hình ảnh mô tả",
                          style: AppStyle.txtMedium14White,
                        ),
                      ),
                      Text(
                        " (Nếu có)",
                        style: AppStyle.txtRegular16Black,
                      ),
                    ],
                  ),
                ),
                (isAddReportImg)
                    ? Container(
                        width: width,
                        height: getVerticalSize(400),
                        margin: getPadding(
                          left: 20,
                          right: 20,
                          bottom: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5, color: ColorConstant.primaryColor),
                          borderRadius: BorderRadius.circular(getSize(15)),
                          image: DecorationImage(
                            image: FileImage(imageFileReport),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : const SizedBox(),
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
                SizedBox(height: getVerticalSize(200),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
