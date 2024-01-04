
import 'package:flutter/cupertino.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';

class CategoryAndProducts{
  int? id;
  String name;
  List<ProductInItemShopping> products;
  PageController controller;

  CategoryAndProducts(this.id, this.name, this.products, this.controller);

}