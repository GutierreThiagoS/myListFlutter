import 'dart:async';

import 'package:floor/floor.dart';
import 'package:my_list_flutter/data/local/dao/category_dao.dart';
import 'package:my_list_flutter/data/local/dao/item_shopping_dao.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/data/local/dao/to_do_dao.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/category.dart';
import 'package:my_list_flutter/domain/model_entity/item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/product.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [
  Product,
  Category,
  ItemShopping,
  ProductInItemShopping,
  ToDoItem
])
abstract class AppDatabase extends FloorDatabase {

  final StreamController<String> _changeListener = StreamController<String>.broadcast();

  Stream<String> get changeListenerStr => _changeListener.stream;

  ProductDao get productDao;
  CategoryDao get categoryDao;
  ItemShoppingDao get itemShoppingDao;
  ToDoDao get todoDao;
}