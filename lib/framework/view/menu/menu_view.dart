
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/framework/view/menu/pages/product_page.dart';
import 'package:my_list_flutter/framework/view/menu/pages/shopping_page.dart';
import 'package:my_list_flutter/main.dart';

class MenuView extends ConsumerWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController _pageController = PageController();

    void onItemTapped(int index) {
      ref.read(injectProductController).setSelectedIndex(index);

      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Principal")),
        body: Container(
          color: Colors.blueGrey,
          child: PageView(
            controller: _pageController,
            children: [
              ShoppingPage(),
              ProductPage(),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.yellow,
              )
            ],
        )),
        floatingActionButton: IconButton(icon: Icon(Icons.add), onPressed: () {},),
        bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: ref.read(injectProductController).indexMenu,
            builder: (_, i, __) {
              return NavigationBar(
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Carrinho',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.list_alt),
                    label: 'Products',
                  ),
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
            }));
  }
}
