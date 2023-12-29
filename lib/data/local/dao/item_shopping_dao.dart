import 'dart:async';

import 'package:floor/floor.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/item_shopping.dart';

@dao
abstract class ItemShoppingDao {

  @insert
  Future<int> insertItemShopping(ItemShopping itemShopping);

  @update
  Future<int> updateItemShopping(ItemShopping itemShopping);

  @delete
  Future<int> deleteItemShopping(ItemShopping itemShopping);

  @Query('SELECT * FROM ItemShopping WHERE id = :id LIMIT 1')
  Future<ItemShopping?> findId(int id);

  @Query('DELETE FROM ItemShopping')
  Future<void> deleteAll();

  @Query(
      'SELECT I.id | 0 AS id, P.id AS productId, P.description AS description, '
          'P.image AS image, P.brand AS brand, C.id AS categoryId, '
          'C.name AS categoryDescription, P.ean AS ean, P.price AS price, '
          'I.quantity AS quantity FROM Product AS P '
          'INNER JOIN ItemShopping AS I ON P.id = I.productId '
          'INNER JOIN Category AS C ON P.categoryIdFk = C.id'
  )
  Future<List<ProductInItemShopping>> getAllShopping();

  @Query(
      'SELECT DISTINCT I.id | 0 AS id, P.id AS productId, P.description AS description, '
          'P.image AS image, P.brand AS brand, C.id AS categoryId, '
          'C.name AS categoryDescription, P.ean AS ean, P.price AS price, '
          'I.quantity AS quantity FROM Product AS P '
          'INNER JOIN ItemShopping AS I ON P.id = I.productId '
          'INNER JOIN Category AS C ON P.categoryIdFk = C.id'
  )
  Stream<List<ProductInItemShopping>> getAllShoppingAsync();
}

