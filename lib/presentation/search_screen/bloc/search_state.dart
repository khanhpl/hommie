import 'package:hommie/core/models/categories/categories.dart';
import 'package:hommie/core/models/list_item/list_item.dart';
import 'package:hommie/core/models/sub_categories/sub_categories.dart';

abstract class SearchState{}
class OtherSearchState extends SearchState{}
class ReturnAllCate extends SearchState{
  ReturnAllCate({required this.categories});
  Categories categories;
}
class ReturnSubCategories extends SearchState{
  ReturnSubCategories({required this.subCategories});
  SubCategories subCategories;
}
class SearchResult extends SearchState{
  SearchResult({required this.listItem});
  ListItem listItem;
}