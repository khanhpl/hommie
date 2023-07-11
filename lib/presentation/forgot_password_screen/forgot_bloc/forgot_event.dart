import '../../../core/app_export.dart';

abstract class ForgotEvent {}
class OtherForgotEvent extends ForgotEvent{}
class SendVerifyCode extends ForgotEvent{
  SendVerifyCode({required this.context});
  BuildContext context;
}
class InputEmail extends ForgotEvent{
  InputEmail({required this.email});
  String email;
}
class InputVerification extends ForgotEvent{
  InputVerification({required this.code});
  String code;
}
class InputOldPass extends ForgotEvent{
  InputOldPass({required this.oldPass});
  String oldPass;
}
class InputNewPass extends ForgotEvent{
  InputNewPass({required this.newPass});
  String newPass;
}
class ChangePass extends ForgotEvent{
  ChangePass({required this.context});
  BuildContext context;
}