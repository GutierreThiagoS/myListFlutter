import 'dart:async';

import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';

abstract class ShoppingRepository {

  Future<List<ProductInItemShopping>> getAllShopping();

  Stream<List<ProductInItemShopping>> getAllShoppingAsync();

}