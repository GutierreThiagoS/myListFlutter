import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model/category_and_products.dart';
import 'package:my_list_flutter/main.dart';

class ItemCatalogCard extends ConsumerStatefulWidget {
  final bool isShopping;
  final CategoryAndProducts categoryAndProducts;
  const ItemCatalogCard({super.key, required this.isShopping, required this.categoryAndProducts});

  @override
  ConsumerState<ItemCatalogCard> createState() => _ItemCatalogCardState();
}

class _ItemCatalogCardState extends ConsumerState<ItemCatalogCard> {
  bool add = true;


  Widget getImageNet(String? image) {
    if (image != null && image.isNotEmpty && (image.contains("http") || image.contains("storage"))) {
      if(image.contains("storage")) {
        return Image.file(File(image));
      } else {
        return getImageNetwork(image);
      }
    } else {
      return  getImageNetwork(
          "https://triunfo.pe.gov.br/pm_tr430/wp-content/uploads/2018/03/sem-foto.jpg"
      );
    }
  }

  Widget getImageNetwork(String image) {
    return Image.network(
      image,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: widget.categoryAndProducts.products.length,
        controller: widget.categoryAndProducts.controller,
        padEnds: false,
        itemBuilder: (_, widgetIndex) {
      return Card(
        child: InkWell(
          onTap: () {

          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${widget.categoryAndProducts.products[widgetIndex].description}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  ),
                ),
                Text("R\$ ${widget.categoryAndProducts.products[widgetIndex].price}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11
                  ),
                ),
                Container(
                  height: 120,
                  alignment: Alignment.center,
                  child: getImageNet(widget.categoryAndProducts.products[widgetIndex].image),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (add) {
                          add = false;
                          widget.categoryAndProducts.products[widgetIndex].quantity =
                              (widget.categoryAndProducts.products[widgetIndex].quantity ?? 0) - 1;
                          ref.read(
                              injectProductController)
                              .refreshProduct(
                              widget.categoryAndProducts.products[widgetIndex]
                          ).then((refresh) {
                            add = true;
                            if (refresh) {
                              setState(() {
                                if ((widget.categoryAndProducts.products[widgetIndex].quantity??0) >= 0) {
                                  widget.categoryAndProducts.products.setAll(widgetIndex, [widget.categoryAndProducts.products[widgetIndex]]);
                                } else {
                                  widget.categoryAndProducts.products[widgetIndex].quantity = 0;
                                  if(widget.isShopping) widget.categoryAndProducts.products.removeAt(widgetIndex);
                                  // if(widget.isShopping && widget.categoryAndProducts.products.isEmpty) widget.categories.removeAt(i);
                                }
                              });
                              ref.read(injectShoppingController).setTotal();
                            }
                          });
                        }
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${widget.categoryAndProducts.products[widgetIndex].quantity ?? 0}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(width: 10,),
                    IconButton(
                        onPressed: () {
                          print(add);
                          if (add) {
                            add = false;
                            widget.categoryAndProducts.products[widgetIndex].quantity =
                                (widget.categoryAndProducts.products[widgetIndex].quantity ?? 0) +
                                    1;
                            ref.read(
                                injectProductController)
                                .refreshProduct(
                                widget.categoryAndProducts.products[widgetIndex]
                            ).then((refresh) {
                              add = true;
                              if (refresh) {
                                setState(() {
                                  widget.categoryAndProducts.products.setAll(widgetIndex, [widget.categoryAndProducts.products[widgetIndex]]);
                                });
                                ref.read(injectShoppingController).setTotal();
                              }
                            });
                          }
                        },
                        icon: const Icon(Icons.add)
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}