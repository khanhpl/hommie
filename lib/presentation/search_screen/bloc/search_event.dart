

import 'package:hommie/core/models/list_item/list_item.dart';

abstract class SearchEvent{}
class OtherSearchEvent extends SearchEvent{}
class GetAllCate extends SearchEvent{}
class GetAllSubCate extends SearchEvent{}
class InputSearchValue extends SearchEvent{
  InputSearchValue({required this.searchValue});
  String searchValue;
}
class ChooseCate extends SearchEvent{
  ChooseCate({required this.cateID});
   int cateID;
}
class ChooseSubCate extends SearchEvent{
  ChooseSubCate({required this.subCateID});
  int subCateID;
}
class Search extends SearchEvent{
}

