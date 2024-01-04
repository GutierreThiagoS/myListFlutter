import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/progress_circular.dart';
import 'package:my_list_flutter/controller/add_product_controller.dart';
import 'package:my_list_flutter/main.dart';
import 'package:my_list_flutter/widget/autocomplete_text_field_widget.dart';
import 'package:my_list_flutter/widget/custom_text_field_widget.dart';

class AddProductView extends ConsumerStatefulWidget {
  const AddProductView({super.key});

  @override
  ConsumerState<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends ConsumerState<AddProductView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: ref.read(injectAddProductController).canPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Adicionar Produto"),
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Registre seu Produto",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextFieldWidget(
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
                      prefixIcon: Icons.qr_code_scanner_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFieldWidget(
                      onChange: ref.read(injectAddProductController).setPrice,
                      label: "Preço",
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
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
                        ),
                        OutlinedButton(
                            onPressed: () {
                              setState(() {
                                ref.read(injectAddProductController).saveNewProduct();
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
