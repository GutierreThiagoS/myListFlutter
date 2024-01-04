import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/framework/utils/text.dart';
import 'package:my_list_flutter/framework/view/menu/pages/notification_page.dart';
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

    return Scaffold(
        appBar: AppBar(
            title: ValueListenableBuilder<int>(
                valueListenable: ref.read(injectProductController).indexMenu,
                builder: (_, i, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(getTitle(i, isSwitch.value)),
                      i == 0
                          ? Row(
                        children: [
                          ValueListenableBuilder<bool>(
                              valueListenable: isSwitch,
                              builder: (_, status, __) => Switch(
                                  thumbIcon: MaterialStatePropertyAll(
                                      Icon(status
                                          ? Icons.shopping_cart
                                          : Icons.shopping_cart_checkout)),
                                  value: status,
                                  onChanged: onChanged
                              )
                          ),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(Icons.calculate_outlined)),
                          SizedBox(width: 10),
                          StreamBuilder<double?>(
                              stream: widget.dao.getTotalAsync(),
                              builder: (_, snapshot) {
                                if (!snapshot.hasData) return Container();
                                final total = snapshot.requireData ?? 0;
                                return Text(
                                  "Total ${formatter.format(total)}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                );
                              })
                        ],
                      )
                          : SizedBox(),
                    ],
                  );
                })
        ),
        body: Container(
            child: PageView(
              controller: pageController,
              onPageChanged: onItemTappedPage,
              children: [
                ValueListenableBuilder<bool>(
                    valueListenable: isSwitch,
                    builder: (_, status, __) =>
                    status ? ShoppingPage(dao: widget.dao) : ProductPage(dao: widget.dao)),
                NotificationPage(dao: widget.dao),
                Container(
                  color: Colors.yellow,
                )
              ],
            )),
        floatingActionButton: IconButton(
          color: Colors.black,
          icon: Icon(Icons.add, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.of(context).pushNamed("/adicionarProduto");
          },
        ),
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
            })
    );
  }
}
