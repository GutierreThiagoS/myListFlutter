import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/progress_circular.dart';
import 'package:my_list_flutter/controller/product_controller.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/main.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: ref.watch(allShoppingInProductsAsync).when(
          data: (data) {
            print(data);
            return Container(
              child: StreamBuilder<List<ProductInItemShopping>>(
                  stream: data,
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      final data = snapshot.requireData;
                      return Container(
                        child: ListView.separated(
                            itemBuilder: (_, i) =>
                                ListTile(
                                  title: Column(
                                    children: [
                                      Text("${data[i].productId} - ${data[i]
                                          .description}"),
                                      Row(
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                data[i].quantity =
                                                    data[i].quantity ?? 0 - 1;
                                                ref.read(injectProductController)
                                                    .refreshProduct(data[i]);
                                              },
                                              child: Icon(Icons.remove)
                                          ),
                                          SizedBox(width: 10,),
                                          Text("${data[i].quantity ?? 0}"),
                                          SizedBox(width: 10,),
                                          OutlinedButton(
                                              onPressed: () {
                                                data[i].quantity =
                                                    data[i].quantity ?? 0 + 1;
                                                ref.read(injectProductController)
                                                    .refreshProduct(data[i]);
                                              },
                                              child: Icon(Icons.add)
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                  },
                                ),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: data.length),
                      );
                    } else {
                      return Text("");
                    }
                  })
            );
          },
          error: (error, stackTrace) => Text("Error"),
          loading: () =>  ProgressCircular()
      ),
    ) ;
  }
}
