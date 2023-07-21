import 'package:flutter/material.dart';

abstract class FeedbackEvent{}
class OtherFeedBackEvent extends FeedbackEvent{}
class ConfirmFeedBack extends FeedbackEvent{
  ConfirmFeedBack({required this.context, required this.content});
  BuildContext context;
  String content;
}