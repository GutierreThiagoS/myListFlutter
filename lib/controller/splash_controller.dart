import 'package:flutter/foundation.dart';
import 'package:my_list_flutter/domain/repository/product_repository.dart';

class SplashController extends ChangeNotifier {
  final ProductRepository _productRepository;
  SplashController(this._productRepository);

  Future<void> checkProduct() async {
    if(kIsWeb) {
      return await _productRepository.checkProductWeb();
    } else {
      return await _productRepository.checkProduct();
    }
  }
}