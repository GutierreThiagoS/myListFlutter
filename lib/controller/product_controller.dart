import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/repository/product_repository.dart';
import 'package:my_list_flutter/main.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository _productRepository;
  ProductController(this._productRepository);

  final ValueNotifier<int> indexMenu = ValueNotifier<int>(0);

  final StreamController<List<ProductInItemShopping>> controllerList = StreamController<List<ProductInItemShopping>>();

  void setSelectedIndex(int i) {
    indexMenu.value = i;
  }

  Future<List<ProductInItemShopping>> getAllProductsShopping() async {
    return _productRepository.getAllProductsShopping();
  }

  /*Stream<List<ProductInItemShopping>> getAllProductsShoppingAsync() {
    return _productRepository.getAllProductsShoppingAsync();
  }*/

  Future<bool> refreshProduct(ProductInItemShopping product) async {
    return await _productRepository.refreshProduct(product);
  }

}

final allShoppingInProducts = FutureProvider<Future<List<ProductInItemShopping>>>((ref) {
  return ref.watch(injectProductController).getAllProductsShopping();
});

/*
final allShoppingInProductsAsync = FutureProvider((ref) {
  return ref.read(injectProductController).getAllProductsShoppingAsync();
});*/
