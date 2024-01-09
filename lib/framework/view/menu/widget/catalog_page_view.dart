import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model/category_and_products.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/framework/view/menu/widget/item_catalog_card.dart';
import 'package:my_list_flutter/main.dart';

class CatalogPageView extends ConsumerStatefulWidget {
  final List<ProductInItemShopping> list;
  final List<CategoryAndProducts> categories;
  final bool isShopping;
  const CatalogPageView(
      {super.key, required this.list, required this.categories, this.isShopping = false});

  @override
  ConsumerState<CatalogPageView> createState() => _CatalogPageViewState();
}

class _CatalogPageViewState extends ConsumerState<CatalogPageView> {

  @override
  Widget build(BuildContext context) {
    ref.read(injectShoppingController).setTotal();

    return ListView.separated(
      shrinkWrap: true,
        itemBuilder: (_, i) {
          return ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Column(
                children: [
            Text(widget.categories[i].name),
            Container(
              height: 260,
              child: ItemCatalogCard(
                  isShopping: widget.isShopping,
                  categoryAndProducts: widget.categories[i]
              )
            )],
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: widget.categories.length
    );
  }
}
