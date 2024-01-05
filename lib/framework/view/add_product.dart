import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/progress_circular.dart';
import 'package:my_list_flutter/controller/add_product_controller.dart';
import 'package:my_list_flutter/domain/model/product_in_item_shopping.dart';
import 'package:my_list_flutter/main.dart';
import 'package:my_list_flutter/widget/autocomplete_text_field_widget.dart';
import 'package:my_list_flutter/widget/custom_text_field_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddProductView extends ConsumerWidget {
  AddProductView({super.key});

/*
  @override
  ConsumerState<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends ConsumerState<AddProductView> {
*/

  ProductInItemShopping? product = null;

  @override
  Widget build(BuildContext context, ref) {

    void _launchURL() {
      final String url = 'https://www.google.com/search?q=${
          ref.read(injectAddProductController).url()
      }';
      launchUrlString(url).then((value) {
        print(value);
      });
    }

    if(product == null) {
      product = ModalRoute
          .of(context)!
          .settings
          .arguments as ProductInItemShopping?;

      if (product != null) {
        print("object $product");
        final controller = ref.read(injectAddProductController);
        controller.setDescription(product?.description ?? "");
        controller.setBrand(product?.brand ?? "");
        controller.setCategory(product?.categoryDescription ?? "");
        controller.setEan(product?.ean ?? "");
        controller.setPrice("${product?.price ?? 0}");
        controller.setImage(product?.image ?? "");
      }
    }

    TextEditingController? getController(String? text) {
      print("object2 $text");
      return (text != null && text.isNotEmpty)
          ? TextEditingController(text: text, )
          : null;
    }

    return PopScope(
      canPop: ref.read(injectAddProductController).canPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${product != null ? "Edite": "Registre"} seu Produto",
            style:
            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black12,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(15),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: ref.read(injectAddProductController).image,
                        builder: (_, image, __) =>
                            Column(
                              children: [
                                Container(
                                  height: 200,
                                  child: GestureDetector(
                                    onTap: _launchURL,
                                    child: Image.network(
                                        image.isNotEmpty && image.contains("http") ? image :
                                        "https://triunfo.pe.gov.br/pm_tr430/wp-content/uploads/2018/03/sem-foto.jpg",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFieldWidget(
                                  onChange: ref.read(injectAddProductController).setImage,
                                  label: "Url da Imagem",
                                  controller: getController(ref.read(injectAddProductController).image.value),
                                  prefixIcon: Icons.image_search,
                                  suffixIcon: Icons.copy_rounded,
                                  onPressedSuffixIcon: () {
                                    Clipboard.getData(Clipboard.kTextPlain).then((value) {
                                      print('Texto colado: ${value?.text}');
                                      ref.read(injectAddProductController).setImage(value?.text??"");
                                    });
                                  },
                                ),
                              ],
                            )
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFieldWidget(
                      controller: getController(ref.read(injectAddProductController).description),
                      onChange:
                          ref.read(injectAddProductController).setDescription,
                      label: "Descrição",
                      prefixIcon: Icons.description,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    ref.watch(allBrand).when(
                        data: (data) => AutocompleteTextFieldWidget(
                            onChange:
                            ref.read(injectAddProductController).setBrand,
                            label: "Marca",
                            options: data,
                            textInit: product?.brand??"",
                            prefixIcon: Icons.list_outlined
                        ),
                        error: (error, stackTrace) => Text("Error: $error"),
                        loading: () => ProgressCircular()
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    ref.watch(allCategoryDescription).when(
                        data: (data) => AutocompleteTextFieldWidget(
                            onChange:
                            ref.read(injectAddProductController).setCategory,
                            label: "Categoria",
                            textInit: product?.categoryDescription??"",
                            options: data,
                            prefixIcon: Icons.format_list_numbered_rounded
                        ),
                        error: (error, stackTrace) => Text("Error: $error"),
                        loading: () => ProgressCircular()
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    CustomTextFieldWidget(
                      onChange: ref.read(injectAddProductController).setEan,
                      label: "Código de Barra",
                      controller: getController(ref.read(injectAddProductController).ean),
                      prefixIcon: Icons.qr_code_scanner_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    CustomTextFieldWidget(
                      onChange: ref.read(injectAddProductController).setPrice,
                      label: "Preço",
                      controller: getController(ref.read(injectAddProductController).price),
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*OutlinedButton(
                            onPressed: ref
                                .read(injectAddProductController)
                                .clearProduct,
                            child: Row(
                              children: [
                                Text("Limpar"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.cleaning_services_rounded)
                              ],
                            )),
                        const SizedBox(
                          width: 25,
                        ),*/
                        OutlinedButton(
                            onPressed: () {
                                ref.read(injectAddProductController).saveNewProduct(product).then((status) {
                                  if(status) {
                                    Navigator.of(context).pop();
                                  }
                                });
                            },
                            child: Row(
                              children: [
                                Text("Adicionar"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.save_rounded)
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
