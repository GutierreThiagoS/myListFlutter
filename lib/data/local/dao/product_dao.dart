
import 'package:floor/floor.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/domain/model_entity/product.dart';

@dao
abstract class ProductDao {

  @insert
  Future<int> insertProduct(Product product);

  @insert
  Future<List<int>> insertAll(List<Product> products);

  @update
  Future<int> updateProduct(Product product);

  @Query('SELECT * FROM Product WHERE id = :id LIMIT 1')
  Future<Product?> findId(int id);

  @Query('SELECT * FROM Product')
  Future<List<Product>> getAll();

  @Query(
      'SELECT I.id | 0 AS id, P.id AS productId, P.description AS description, '
          'P.image AS image, P.brand AS brand, C.id AS categoryId, '
          'C.name AS categoryDescription, P.ean AS ean, P.price AS price, '
          'I.quantity AS quantity FROM Product AS P '
          'LEFT JOIN ItemShopping AS I ON P.id = I.productId '
          'LEFT JOIN Category AS C ON P.categoryIdFk = C.id'
  )
  Future<List<ProductInItemShopping>> getAllShopping();

  @Query(
      'SELECT I.id | 0 AS id, P.id AS productId, P.description AS description, '
          'P.image AS image, P.brand AS brand, C.id AS categoryId, '
          'C.name AS categoryDescription, P.ean AS ean, P.price AS price, '
          'I.quantity AS quantity FROM Product AS P '
          'LEFT JOIN ItemShopping AS I ON P.id = I.productId '
          'LEFT JOIN Category AS C ON P.categoryIdFk = C.id'
  )
  Stream<List<ProductInItemShopping>> getAllShoppingAsync();

  @Query('DELETE FROM Product')
  Future<void> deleteAll();
}