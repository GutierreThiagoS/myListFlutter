
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_list_flutter/data/local/database.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/product.dart';
import 'package:my_list_flutter/domain/repository/product_repository.dart';
import 'package:my_list_flutter/framework/utils/mock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImp implements ProductRepository {

  @override
  Future<void> checkProduct() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final categoryDao = database.categoryDao;
      final productDao = database.productDao;
      if ((await categoryDao.getAll()).isEmpty) {
        categoryDao.insertAll(categories);
      }
      if ((await productDao.getAll()).isEmpty) {
        productDao.insertAll(products);
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Future<void> checkProductWeb() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("categories")) {
        prefs.setString("categories", jsonEncode(categories.map((e) => e.toJson()).toList()));
      }
      if (!prefs.containsKey("products")) {
        prefs.setString("products", jsonEncode(products.map((e) => e.toJson()).toList()));
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      if (kIsWeb) {
        var prefs = await SharedPreferences.getInstance();
        var productPrefs = prefs.getString("products");
        print("productPrefs $productPrefs");
        List<dynamic> decode = jsonDecode(productPrefs!);
        print("decode $decode");
        List<Product> list = decode.map((e) {
          print(e);
          return Product.fromJson(e);
        }).toList();
        print("list $list");
        return list;  //productPrefs!.split(',').map((e) => Product.fromJson(e as Map)).toList();
      } else {
        final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        final productDao = database.productDao;
        return await productDao.getAll();
      }
    } catch(e) {
      print("getAllProducts $e");
      return [];
    }
  }

  @override
  Future<bool> refreshProduct(ProductInItemShopping product) async {
    try {
      if (kIsWeb) {
        return false;
      } else {
        final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        final itemShoppingDao = database.itemShoppingDao;

        print("ProductInItemShopping $product");
        final item = await itemShoppingDao.findId(product.id ?? 0, product.productId ?? 0);
        print("item $item");
        if (item != null) {
          item.quantity = product.quantity??0;
          if (item.quantity >= 0) {
            print("ProductInItemShopping update.quantity ${item.quantity}");
            final up = await itemShoppingDao.updateItemShopping(item);
            return up > 0;
          } else {
            print("ProductInItemShopping delete.quantity ${item.quantity}");
            final up = await itemShoppingDao.deleteItemShopping(item);
            return up > 0;
          }
        } else {
          print("ProductInItemShopping item null insert product");
          if ((product.quantity??0) >= 0) {
            final newItem = ItemShopping(
                null, product.productId ?? 0, product.quantity ?? 0);
            print("newItem $newItem");

            final up = await itemShoppingDao.insertItemShopping(newItem);
            return up > 0;
          } else {
            return true;
          }
        }
      }
    } catch(e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<ProductInItemShopping>> getAllProductsShopping() async {
    try {
      if(kIsWeb) {
        return [];
      } else {
        final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        final productDao = database.productDao;
        print("getAllProductsShopping");
        final list = await productDao.getAllShopping();
        print(list);
        return list;
      }
    } catch(e) {
      print("ShoppingRepositoryImp $e");
      return [];
    }
  }

  @override
  Future<bool> saveProduct(Product product) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final productDao = database.productDao;
      if(product.id == null) {
        final up = await productDao.insertProduct(product);
        return up > 0;
      } else {
        final up = await productDao.updateProduct(product);
        return up > 0;
      }
    } catch(e) {
      print("e");
      return false;
    }
  }

 /* Stream<List<ProductInItemShopping>> getAllProductsShoppingAsync() {
    return _productDao.getAllShoppingAsync();
  }*/
}