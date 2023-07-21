import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/user_info/user_info.dart';
import 'package:hommie/presentation/personal_information_screen/personal_bloc/personal_bloc.dart';
import 'package:hommie/presentation/personal_information_screen/personal_bloc/personal_event.dart';
import 'package:hommie/presentation/personal_information_screen/personal_bloc/personal_state.dart';
import 'package:hommie/widgets/custom_text_form_field2.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _personalBloc = PersonalBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _genderList = ["Nam", "Nữ", "Khác"];
  String _groupValue = "Nam";
  DateTime selectedDate = DateTime.now();
  UserInfo? userInfo;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _personalBloc.eventController.sink.add(GetUserInfo());
    _personalBloc.eventController.sink.add(ChooseGender(gender: _groupValue));
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _personalBloc.stateController.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data is ReturnUserInfo){
            userInfo = (snapshot.data as ReturnUserInfo).userInfo;
            _nameController = TextEditingController(text: userInfo!.data.name);
            _personalBloc.eventController.sink.add(InputName(name: userInfo!.data.name));
            _phoneController = TextEditingController(text: userInfo!.data.phoneNumber);
            _personalBloc.eventController.sink.add(InputPhone(phone: userInfo!.data.phoneNumber));
            if(userInfo!.data.address != null){
              _addressController = TextEditingController(text: userInfo!.data.address);
              _personalBloc.eventController.sink.add(InputAddress(address: userInfo!.data.address));
            }
            if(userInfo!.data.gender != null){
              _groupValue = userInfo!.data.gender;
              _personalBloc.eventController.sink.add(ChooseGender(gender: userInfo!.data.gender));
            }
            if(userInfo!.data.dob != null){
              _dobController = TextEditingController(text: userInfo!.data.dob);
              _personalBloc.eventController.sink.add(ChooseDOB(dob: userInfo!.data.dob));
            }
          }
        }
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
                    "Thông tin cá nhân",
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
                  _personalBloc.eventController.sink.add(UpdateInfo(context: context));
                }
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: Material(
              child: Container(
                width: width,
                height: height,
                color: Colors.white,
                alignment: Alignment.topCenter,
                padding: getPadding(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 100,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        CustomTextFormField2(
                          focusNode: FocusNode(),
                          controller: _nameController,
                          labelText: "Họ và tên",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            _personalBloc.eventController.sink.add(InputName(name: value.toString().trim()));
                            if(value == null || value.toString().trim().isEmpty){
                              return "Vui lòng không bỏ trống họ và tên";
                            }
                            return null;
                          },
                        ),

                      CustomTextFormField2(
                        focusNode: FocusNode(),
                        margin: getMargin(
                          top: 20
                        ),
                        controller: _phoneController,
                        labelText: "Số điện thoại",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          _personalBloc.eventController.sink.add(InputPhone(phone: value.toString().trim()));
                          if(value == null || value.toString().trim().length != 10){
                            return "Số điện thoại phải có 10 ký tự";
                          }
                          return null;
                        },
                      ),

                      CustomTextFormField2(
                        focusNode: FocusNode(),
                        margin: getMargin(
                            top: 20
                        ),
                        controller: _addressController,
                        labelText: "Địa chỉ",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.streetAddress,
                        validator: (value) {
                          _personalBloc.eventController.sink.add(InputAddress(address: value.toString().trim()));
                          if(value == null || value.toString().trim().isEmpty){
                            return "Vui lòng không để trống địa chỉ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: getHorizontalSize(70),
                        child: RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          groupValue: _groupValue,
                          horizontalAlignment: MainAxisAlignment.spaceAround,
                          onChanged: (value) => setState(() {
                            _groupValue = value ?? '';
                            _personalBloc.eventController.sink.add(ChooseGender(gender: _groupValue));
                          }),
                          items: _genderList,
                          textStyle: TextStyle(
                            fontSize: getSize(15),
                            color: Colors.black,
                          ),
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          DatePicker.showDatePicker(context,
                              //showDateTime to pick time
                              showTitleActions: true,
                              minTime: DateTime(1950, 1, 1),
                              maxTime: DateTime.now(),
                              onChanged: (date) {}, onConfirm: (date) {
                                setState(() {
                                  String dateInput =
                                      '${(date.day >= 10) ? date.day : '0${date.day}'}-${(date.month >= 10) ? date.month : '0${date.month}'}-${date.year}';
                                  _dobController = TextEditingController(text: dateInput);
                                  _personalBloc.eventController.sink.add(ChooseDOB(dob: dateInput));
                                });
                              },

                              currentTime: DateTime.now(),
                              locale: LocaleType.vi);
                        },
                        child: CustomTextFormField2(
                          isEnabled: false,
                          focusNode: FocusNode(),
                          margin: getMargin(
                              top: 20
                          ),
                          controller: _dobController,
                          labelText: "Ngày sinh",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if(value == null || value.toString().trim().isEmpty){
                              return "Vui lòng không để trống ngày sinh";
                            }
                            return null;
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
