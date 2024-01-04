import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:my_list_flutter/data/local/database.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/repository/shopping_repository.dart';

class ShoppingRepositoryImp implements ShoppingRepository {


  @override
  Future<List<ProductInItemShopping>> getAllShopping() async{
    try {
      if(foundation.kIsWeb) {
        return [];
      } else {
        final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        final itemShoppingDao = database.itemShoppingDao;
        print("itemShoppingDao");
        final list = await itemShoppingDao.getAllShopping();
        print(list);
        return list;
      }
    } catch(e) {
      print("ShoppingRepositoryImp $e");
      return [];
    }
  }

/*
  @override
  Stream<List<ProductInItemShopping>> getAllShoppingAsync() {
    return _itemShoppingDao!.getAllShoppingAsync();
  }
*/

/*  @override
  Future<List<Category>> getAllCategory() {
    return _itemShoppingDao!.getAllCategory();
  }*/

}