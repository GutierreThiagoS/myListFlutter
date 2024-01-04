
import 'package:my_list_flutter/data/local/database.dart';
import 'package:my_list_flutter/domain/model_entity/category.dart';
import 'package:my_list_flutter/domain/repository/category_repository.dart';

class CategoryRepositoryImp implements CategoryRepository {

  @override
  Future<List<String>> getAllBrand() async {
     try {
       final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
       final categoryDao = database.categoryDao;
       return categoryDao.getAllBrand();
     } catch(e) {
       print(e);
       return [];
     }
  }

  @override
  Future<List<String>> getAllDescription() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final categoryDao = database.categoryDao;
      return categoryDao.getAllDescription();
    } catch(e) {
      print(e);
      return [];
    }
  }

  @override
  Future<Category?> getCategoryName(String name) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final categoryDao = database.categoryDao;
      final category = await categoryDao.findName(name);
      if (category != null) {
        return category;
      } else {
        final newCategory = Category(null, name);
        await categoryDao.insertCategory(newCategory);
        return await categoryDao.findName(name);
      }
    } catch(e) {
      print(e);
      return null;
    }
  }

}