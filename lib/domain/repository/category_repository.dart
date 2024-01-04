
import 'package:my_list_flutter/domain/model_entity/category.dart';

abstract class CategoryRepository {

  Future<List<String>> getAllDescription();

  Future<List<String>> getAllBrand();

  Future<Category?> getCategoryName(String name);
}