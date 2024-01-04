import 'dart:async';

import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';

abstract class ShoppingRepository {

  Future<List<ProductInItemShopping>> getAllShopping();

  // Future<List<Category>> getAllCategory();

  // Stream<List<ProductInItemShopping>> getAllShoppingAsync();

}