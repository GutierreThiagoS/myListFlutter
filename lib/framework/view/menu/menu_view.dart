import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/framework/utils/text.dart';
import 'package:my_list_flutter/framework/view/menu/pages/config_page.dart';
import 'package:my_list_flutter/framework/view/menu/pages/to_do_page.dart';
import 'package:my_list_flutter/framework/view/menu/pages/product_page.dart';
import 'package:my_list_flutter/framework/view/menu/pages/shopping_page.dart';
import 'package:my_list_flutter/main.dart';

class MenuView extends ConsumerStatefulWidget {
  final ProductDao dao;

  const MenuView({super.key, required this.dao});

  @override
  ConsumerState<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends ConsumerState<MenuView> {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    final PageController pageController = PageController();

    void onItemTapped(int index) {
      ref.read(injectProductController).setSelectedIndex(index);

      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 1), curve: Curves.ease);
    }

    void onItemTappedPage(int index) {
      ref.read(injectProductController).setSelectedIndex(index);

      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }

    ValueNotifier<bool> isSwitch = ValueNotifier<bool>(false);

    void onChanged(bool value) {
      isSwitch.value = value;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (pop) {
        print("Pop $pop");
      },
      child: Scaffold(
          appBar: AppBar(
              title: ValueListenableBuilder<int>(
                  valueListenable: ref.read(injectProductController).indexMenu,
                  builder: (_, i, __) {
                    return ValueListenableBuilder<bool>(
                        valueListenable: isSwitch,
                        builder: (_, status, __) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getTitle(i, isSwitch.value)),
                              i == 0
                                  ? Row(children: [
                                      Switch(
                                          thumbIcon: MaterialStatePropertyAll(
                                              Icon(status
                                                  ? Icons.shopping_cart
                                                  : Icons
                                                      .shopping_cart_checkout)),
                                          value: status,
                                          onChanged: onChanged),
                                      const SizedBox(width: 10),
                                      ValueListenableBuilder<double>(
                                          valueListenable: ref
                                              .read(injectShoppingController)
                                              .total,
                                          builder: (_, total, __) {
                                            return Text(
                                              "Total ${formatter.format(total)}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          })
                                    ])
                                  : const SizedBox(),
                            ],
                          );
                        });
                  })),
          body: Container(
              child: PageView(
            controller: pageController,
            onPageChanged: onItemTappedPage,
            children: [
              ValueListenableBuilder<bool>(
                  valueListenable: isSwitch,
                  builder: (_, status, __) => status
                      ? ShoppingPage(dao: widget.dao)
                      : ProductPage(dao: widget.dao)),
              ToDoListPage(dao: widget.dao),
              const ConfigurationPage()
            ],
          )),
          floatingActionButton: ValueListenableBuilder<int>(
              valueListenable: ref.read(injectProductController).indexMenu,
              builder: (_, i, __) {
                return ref.read(injectProductController).isNavigationInConfig()
                    ? Container()
                    : FloatingActionButton(
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(200.0),
                          ),
                        ),
                        onPressed: () {
                          if (ref
                              .read(injectProductController)
                              .isNavigationInShopping()) {
                            ref.read(injectAddProductController).clearProduct();
                            Navigator.of(context)
                                .pushNamed("/adicionarProduto");
                          } else if (ref
                              .read(injectProductController)
                              .isNavigationInTodo()) {
                            Navigator.of(context)
                                .pushNamed("/adicionarLembrete");
                          }
                        },
                        child: const Icon(Icons.add, color: Colors.white));
              }),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: ValueListenableBuilder<int>(
              valueListenable: ref.read(injectProductController).indexMenu,
              builder: (_, i, __) {
                return NavigationBar(
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.shopping_cart),
                      label: 'Carrinho',
                    ),
                    /*NavigationDestination(
                      icon: Icon(Icons.list_alt),
                      label: 'Produtos',
                    ),*/
                    NavigationDestination(
                      icon: Icon(Icons.calendar_month),
                      label: 'Lembretes',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.manage_accounts),
                      label: 'Config',
                    ),
                  ],
                  selectedIndex: i,
                  onDestinationSelected: onItemTapped,
                );
              })),
    );
  }
}
