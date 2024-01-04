
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model_entity/product.dart';
import 'package:my_list_flutter/domain/repository/category_repository.dart';
import 'package:my_list_flutter/domain/repository/product_repository.dart';
import 'package:my_list_flutter/main.dart';

class AddProductController extends ChangeNotifier {

  final CategoryRepository _categoryRepository;
  final ProductRepository _productRepository;
  AddProductController(this._categoryRepository, this._productRepository);

  bool canPop = true;

  String _description = "";
  setDescription(String value) => _description = value;

  String _brand = "";
  setBrand(String value) => _brand = value;

  String _category = "";
  setCategory(String value) => _category = value;

  String _ean = "";
  setEan(String value) => _ean = value;

  String _price = "";
  setPrice(String value) => _price = value;

  Future<List<String>> getAllCategoryDescription() async {
    return _categoryRepository.getAllDescription();
  }

  Future<List<String>> getAllBrand() async {
    return _categoryRepository.getAllBrand();
  }

  Future<bool> saveNewProduct() async {

    if(_description.isNotEmpty &&
        _category.isNotEmpty &&
        _price.isNotEmpty &&
        double.tryParse(_price) != null
    ) {
      final categoryDb = await _categoryRepository.getCategoryName(_category);
      if (categoryDb != null) {
        canPop = true;
        print("${double.tryParse(_price)}");
        _productRepository.saveProduct(
            Product(
                null,
                _description,
                "",
                _brand,
                categoryDb.id,
                _ean,
                double.parse(_price)
            )
        );
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void clearProduct() {
    _description = "";
    _brand = "";
    _category = "";
    _ean = "";
    _price = "";
  }
}

final allCategoryDescription = FutureProvider((ref) {
  return ref.watch(injectAddProductController).getAllCategoryDescription();
});

final allBrand = FutureProvider((ref) {
  return ref.watch(injectAddProductController).getAllBrand();
});

