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
        return Image.network(image);
      }
    } else {
      return  Image.network(
          "https://triunfo.pe.gov.br/pm_tr430/wp-content/uploads/2018/03/sem-foto.jpg"
      );
    }
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
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            widget.categoryAndProducts.products[widgetIndex].description??"",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(children: [
                          ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                              child: Row(children: [
                                Text("Cancelar"),
                                SizedBox(width: 8),
                                Icon(Icons.cancel)
                              ])
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/adicionarProduto", arguments: widget.categoryAndProducts.products[widgetIndex]);
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                              child: Row(children: [
                                Text("Editar"),
                                SizedBox(width: 8),
                                Icon(Icons.edit_outlined)
                              ])
                          )
                        ]),
                      ],
                    )
            ));
                },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${widget.categoryAndProducts.products[widgetIndex].description}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  ),
                ),
                Text("R\$ ${widget.categoryAndProducts.products[widgetIndex].price}",
                  style: TextStyle(
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
                      icon: Icon(Icons.remove),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${widget.categoryAndProducts.products[widgetIndex].quantity ?? 0}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    SizedBox(width: 10,),
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
                        icon: Icon(Icons.add)
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