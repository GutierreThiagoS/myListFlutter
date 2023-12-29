import 'package:floor/floor.dart';

@entity
class ItemShopping {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? productId;
  int quantity;

  ItemShopping(this.id, this.productId, this.quantity);

  factory ItemShopping.fromJson(Map json) {
    return ItemShopping(
        json['id'],
        json['productId'],
        json['quantity']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity
    };
  }
}