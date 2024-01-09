import 'package:floor/floor.dart';

@entity
class Product {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String description;
  String image;
  String brand;
  int? categoryIdFk;
  String ean;
  double price;

  Product(this.id, this.description, this.image, this.brand, this.categoryIdFk, this.ean, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        json['id'] as int,
        json['description'] as String,
        json['image'] as String,
        json['brand'] as String,
        json['categoryIdFk'] as int,
        json['ean'] as String,
        json['price'] as double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'image': image,
      'brand': brand,
      'categoryIdFk': categoryIdFk,
      'ean': ean,
      'price': price,
    };
  }
}