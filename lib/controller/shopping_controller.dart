
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/repository/shopping_repository.dart';
import 'package:my_list_flutter/main.dart';

class ShoppingController extends ChangeNotifier {

  final ShoppingRepository _shoppingRepository;
  ShoppingController(this._shoppingRepository);

  Future<List<ProductInItemShopping>> getAllShoppingAsync() async {
    await Future.delayed(Duration(seconds: 10));
    return _shoppingRepository.getAllShopping();
  }

  Stream<List<ProductInItemShopping>> getAllShoppingAsyncStream() {
    return _shoppingRepository.getAllShoppingAsync();
  }
}

final shoppingAll = FutureProvider((ref) {
  return ref.read(injectShoppingController).getAllShoppingAsync();
});

final shoppingAllSync = FutureProvider((ref) {
  return ref.read(injectShoppingController).getAllShoppingAsyncStream();
});
