import 'dart:async';
import 'dart:convert';

import 'package:hommie/core/models/categories/categories.dart';
import 'package:hommie/core/models/list_item/list_item.dart';
import 'package:hommie/core/models/sub_categories/sub_categories.dart';
import 'package:hommie/presentation/search_screen/bloc/search_event.dart';
import 'package:hommie/presentation/search_screen/bloc/search_state.dart';
import 'package:http/http.dart' as http;
import 'package:hommie/core/app_export.dart';
import 'package:hommie/core/models/categories/category.dart';

class SearchBloc{
  final eventController = StreamController<SearchEvent>();
  final stateController = StreamController<SearchState>();
  int cateID = -1;
  int subCateID = -1;
  SearchBloc(){
    eventController.stream.listen((event) {
      if(event is OtherSearchEvent){
        stateController.sink.add(OtherSearchState());
      }
      if(event is GetAllCate){
        getAllCate();
      }
      if(event is ChooseCate){
        subCateID = -1;
        cateID = event.cate.id;
        stateController.sink.add(ReturnSelectedCate(cate: event.cate));
      }
      if(event is ChooseSubCate){
        subCateID = event.subCate.id;
        stateController.sink.add(ReturnSelectedSubCate(subCate: event.subCate));
      }
      if(event is GetSubCateByCateID){
        getSubCategories(event.cateID);
      }
      if(event is Search){
        getItems(event.searchValue);
      }
    });
  }
  Future<void> getAllCate() async {
    try {
      var url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/category/get-all-category");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },

      );
      if (response.statusCode.toString() == '200') {
        Categories categories = Categories.fromJson(json.decode(response.body));
        stateController.sink.add(ReturnAllCate(categories: categories));
      } else {
        print('fail: ');
      }
    } finally {}
  }
  Future<void> getSubCategories(int cateID) async {
    try {
      var url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/subcategory/get-all-sub_cate-by?cateId=$cateID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },

      );
      print('Test getSubCategories status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        SubCategories subCategories = SubCategories.fromJson(json.decode(response.body));
        stateController.sink.add(ReturnSubCategories(subCategories: subCategories));
      } else {
        print('fail: ');
      }
    } finally {}
  }
  Future<void> getItems(String searchValue) async {
    try {
      Uri url;
      if(searchValue.isEmpty){
        if(cateID!=-1){
          if(subCateID != -1){
            url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/item/get-all-item-by?cateId=$cateID&subId=$subCateID");
          }else{
            url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/item/get-all-item-by?cateId=$cateID");
          }
        }else{
          url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/item/get-all-item-by");

        }
      }else{
        if(cateID!=-1){
          if(subCateID != -1){
            url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/item/get-all-item-by?cateId=$cateID&subId=$subCateID&keyWord=$searchValue");
          }else{
            url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/item/get-all-item-by?cateId=$cateID&keyWord=$searchValue");
          }
        }else{
          url = Uri.parse("https://tiemhommie-0835ad80e9db.herokuapp.com/api/item/get-all-item-by?keyWord=$searchValue");

        }
      }
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken'
        },
        body: jsonEncode(
          <String, dynamic>{
          },
        ),
      );
      print('Test getItems status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        ListItem listItem = ListItem.fromJson(json.decode(response.body));
        stateController.sink.add(SearchResult(listItem: listItem));
      } else {
        print('fail: ');
      }
    } finally {}
  }
}