import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/progress_circular.dart';
import 'package:my_list_flutter/controller/shopping_controller.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';

class ShoppingPage extends ConsumerWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: ref.watch(shoppingAllSync).when(
          data: (data) {
            print(data);
            print(data.isBroadcast);

            return Container(
                child: StreamBuilder<List<ProductInItemShopping>>(
                    stream: data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.requireData;
                        return Container(
                            child: ListView.separated(
                                itemBuilder: (_, i) => ListTile(
                                      title: Text(
                                          "${data[i].quantity} - ${data[i].description}"),
                                      onTap: () {

                                      },
                                    ),
                                separatorBuilder: (_, __) => const Divider(),
                                itemCount: data.length));
                      } else {
                        return Text("Carregando...");
                      }
                    }));
          },
          error: (error, stackTrace) => Text("Error $error"),
          loading: () => ProgressCircular()),
    );
  }
}
