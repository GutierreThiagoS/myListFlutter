import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/product.dart';

abstract class ProductRepository {

  Future<void> checkProduct();

  Future<void> checkProductWeb();

  Future<List<Product>> getAllProducts();

  Future<List<ProductInItemShopping>> getAllProductsShopping();

  Stream<List<ProductInItemShopping>> getAllProductsShoppingAsync();

  Future<void> refreshProduct(ProductInItemShopping product);
}