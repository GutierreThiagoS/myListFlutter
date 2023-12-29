
import 'package:floor/floor.dart';

@entity
class ProductInItemShopping {
  @primaryKey
  int? id = 0;
  int? productId = 0;
  String? description = "";
  String? image = "";
  String? brand = "";
  int? categoryId = 0;
  String? categoryDescription = "";
  String? ean = "";
  double? price = 0;
  int? quantity = 0;

  ProductInItemShopping(
      this.id,
      this.productId,
      this.description,
      this.image,
      this.brand,
      this.categoryId,
      this.categoryDescription,
      this.ean,
      this.price,
      this.quantity
  );

  @override
  String toString() {
    return "id $id, productId $productId, description $description, image $image, brand $brand, categoryId $categoryId, categoryDescription $categoryDescription, quantity $quantity";
  }
}
