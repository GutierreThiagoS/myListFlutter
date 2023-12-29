
import 'package:floor/floor.dart';
import 'package:my_list_flutter/domain/model_entity/category.dart';


@dao
abstract class CategoryDao {
  @insert
  Future<void> insertCategory(Category category);

  @insert
  Future<List<int>> insertAll(List<Category> categories);

  @Query('SELECT * FROM Category')
  Future<List<Category>> getAll();

  @Query('SELECT * FROM Category WHERE id = :id LIMIT 1')
  Future<Category?> findId(int id);

  @Query('DELETE FROM Category')
  Future<void> deleteAll();

}