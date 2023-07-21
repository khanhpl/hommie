import 'package:hommie/core/app_export.dart';
import 'package:hommie/presentation/feedback_screen/bloc/feedback_bloc.dart';
import 'package:hommie/presentation/feedback_screen/bloc/feedback_event.dart';

import '../../widgets/custom_text_form_field2.dart';
class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final _feedbackBloc = FeedBackBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                "Đóng Góp Cho Hệ Thống",
                style: AppStyle.txtRobotoRomanBold24,
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
            if (_formKey.currentState!.validate()) {
              _feedbackBloc.eventController.sink.add(ConfirmFeedBack(context: context, content: _contentController.text.trim()));
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          padding: getPadding(
            top: 20
          ),
          child:  CustomTextFormField2(
            hintText: "Nội dung",
            focusNode: FocusNode(),
            controller: _contentController,
            width: width,
            maxLines: 10,
            margin: getMargin(
              left: 10,
              right: 10,
            ),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
            isObscureText: false,
            validator: (value) {
              if(value == null || value.toString().trim().isEmpty){
                return "Vui lòng nhập nội dung";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
