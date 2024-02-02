import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/framework/config_notification/config_notificationn.dart';
import 'package:my_list_flutter/framework/config_notification/received_notification.dart';
import 'package:my_list_flutter/framework/utils/text.dart';
import 'package:my_list_flutter/framework/view/menu/pages/config_page.dart';
import 'package:my_list_flutter/framework/view/menu/pages/to_do_page.dart';
import 'package:my_list_flutter/framework/view/menu/pages/product_page.dart';
import 'package:my_list_flutter/framework/view/menu/pages/shopping_page.dart';
import 'package:my_list_flutter/main.dart';

class MenuView extends ConsumerStatefulWidget {
  final ProductDao dao;
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  const MenuView({super.key, required this.dao, this.notificationAppLaunchDetails});

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  ConsumerState<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends ConsumerState<MenuView> {

  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  Future<void> _isAndroidPermissionGranted() async {
    print("TESTE");
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
      await androidImplementation?.requestNotificationsPermission();
      setState(() {
        _notificationsEnabled = grantedNotificationPermission ?? false;
      });
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title!) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body!) : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.of(context).pushNamed("/");
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(context).pushNamed("/");
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.dispose();
  }

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
                  }),
            elevation: 10,
          ),
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
                                .pushNamed("/adicionarProduto").then((value) {
                              setState(() {
                                print("$value adicionarProduto teste");
                              });
                            });;
                          } else if (ref
                              .read(injectProductController)
                              .isNavigationInTodo()) {
                            ref.read(injectAddToDoController).clearToDoList();
                            Navigator.of(context)
                                .pushNamed("/adicionarLembrete").then((value) {
                              setState(() {
                                print("$value adicionarProduto teste");
                              });
                            });;
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
