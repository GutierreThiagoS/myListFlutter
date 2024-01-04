
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/repository/shopping_repository.dart';
import 'package:my_list_flutter/main.dart';

class ShoppingController extends ChangeNotifier {

  final ShoppingRepository _shoppingRepository;
  ShoppingController(this._shoppingRepository);

  final ValueNotifier<double> total = ValueNotifier<double>(0);

  final ValueNotifier<List<ProductInItemShopping>> productsInShopping = ValueNotifier<List<ProductInItemShopping>>([]);


  Future<List<ProductInItemShopping>> getAllShoppingAsync() async {
    setTotal(await _shoppingRepository.getAllShopping());
    return _shoppingRepository.getAllShopping();
  }

  void setTotal(List<ProductInItemShopping> data) {
    try {
      var totalMap = data.map((element) => (element.price??0) * (element.quantity??0));
      total.value = totalMap.reduce((value, element) => value + element);
    } catch(e) {
      print(e);
    }
  }
}

final shoppingAll = FutureProvider<Future<List<ProductInItemShopping>>>((ref) {
  return ref.watch(injectShoppingController).getAllShoppingAsync();
});
