import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/custom_progress.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/domain/model/category_and_products.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/framework/utils/text.dart';
import 'package:my_list_flutter/framework/view/menu/widget/catalog_page_view.dart';

class ShoppingPage extends ConsumerStatefulWidget {
  final ProductDao dao;
  const ShoppingPage({super.key, required this.dao});

  @override
  ConsumerState<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends ConsumerState<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: StreamBuilder<List<ProductInItemShopping>>(
          stream: widget.dao.getAllShoppingAsync(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) return const CustomProgress();
            final data = snapshot.requireData;
            List<CategoryAndProducts> categories = data
                .map((e) {
                  return CategoryAndProducts(
                      e.categoryId,
                      e.categoryDescription ?? "",
                      data.where(
                              (element) => element.categoryId == (e.categoryId ?? 0)
                      ).toList(),
                      PageController(viewportFraction: 0.45));
                })
                .toList()
                .distinctBy((d) => d.id!)
                .toList();

            return CatalogPageView(
              isShopping: true,
                list: data,
                categories: categories
            );
          },
        )
    );
  }
}
