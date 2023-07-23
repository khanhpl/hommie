import '../../../core/app_export.dart';

abstract class ChangePasswordEvent{}
class ChangePass extends ChangePasswordEvent{
  ChangePass({required this.context, required this.oldPass, required this.newPass});
  BuildContext context;
  String oldPass;
  String newPass;
}