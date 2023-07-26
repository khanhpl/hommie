import 'package:flutter/material.dart';

abstract class ReportEvent{}
class OtherReportEvent extends ReportEvent{}
class ConfirmReport extends ReportEvent{
  ConfirmReport({required this.context, required this.image, required this.reason, required this.orderCode});
  BuildContext context;
  String image;
  String reason;
  String orderCode;
}