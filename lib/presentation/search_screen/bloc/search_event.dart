


import 'package:hommie/core/models/sub_categories/sub_category.dart';

import '../../../core/models/categories/category.dart';

abstract class SearchEvent{}
class OtherSearchEvent extends SearchEvent{}
class GetAllCate extends SearchEvent{}
class GetAllSubCate extends SearchEvent{}
class InputSearchValue extends SearchEvent{
  InputSearchValue({required this.searchValue});
  String searchValue;
}
class ChooseCate extends SearchEvent{
  ChooseCate({required this.cate});

  Category cate;
}
class ChooseSubCate extends SearchEvent{
  ChooseSubCate({required this.subCate});
  SubCategory subCate;
}
class Search extends SearchEvent{
}

class GetSubCateByCateID extends SearchEvent{
  GetSubCateByCateID({required this.cateID});
  int cateID;
}

