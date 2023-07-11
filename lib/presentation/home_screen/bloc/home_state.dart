import 'package:hommie/core/models/list_item/list_item.dart';

abstract class HomeState{}
class OtherHomeState extends HomeState{}
class ReturnLatestItems extends HomeState{
  ReturnLatestItems({required this.listItem});
  ListItem listItem;
}