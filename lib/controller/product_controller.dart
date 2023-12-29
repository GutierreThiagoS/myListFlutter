import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/product.dart';
import 'package:my_list_flutter/domain/repository/product_repository.dart';
import 'package:my_list_flutter/main.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository _productRepository;
  ProductController(this._productRepository);

  final ValueNotifier<int> indexMenu = ValueNotifier<int>(0);

  void setSelectedIndex(int i) {
    indexMenu.value = i;
  }

  Future<List<Product>> getAllProducts() async {
    return await _productRepository.getAllProducts();
  }

  Future<List<ProductInItemShopping>> getAllProductsShopping() async {
    await Future.delayed(Duration(seconds: 3));
    return await _productRepository.getAllProductsShopping();
  }

  Stream<List<ProductInItemShopping>> getAllProductsShoppingAsync() {
    return _productRepository.getAllProductsShoppingAsync();
  }


  Future<void> refreshProduct(ProductInItemShopping product) async {
    final refresh = await _productRepository.refreshProduct(product);
    /*if (refresh) {

    }*/
  }
}

final allProducts = FutureProvider((ref) {
  return ref.read(injectProductController).getAllProducts();
});

final allShoppingInProducts = FutureProvider((ref) {
  return ref.read(injectProductController).getAllProductsShopping();
});

final allShoppingInProductsAsync = FutureProvider((ref) {
  return ref.read(injectProductController).getAllProductsShoppingAsync();
});