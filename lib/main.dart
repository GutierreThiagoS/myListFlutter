import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_list_flutter/framework/config_notification/config_notificationn.dart';
import 'package:my_list_flutter/framework/config_notification/received_notification.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/controller/add_product_controller.dart';
import 'package:my_list_flutter/controller/add_to_do_controller.dart';
import 'package:my_list_flutter/controller/product_controller.dart';
import 'package:my_list_flutter/controller/shopping_controller.dart';
import 'package:my_list_flutter/controller/splash_controller.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/data/local/database.dart';
import 'package:my_list_flutter/data/repository/category_repository_imp.dart';
import 'package:my_list_flutter/data/repository/product_repository_imp.dart';
import 'package:my_list_flutter/data/repository/shopping_repository_imp.dart';
import 'package:my_list_flutter/data/repository/to_do_task_repository_imp.dart';
import 'package:my_list_flutter/framework/view/add_product.dart';
import 'package:my_list_flutter/framework/view/add_to_do_alert.dart';
import 'package:my_list_flutter/framework/view/menu/menu_view.dart';
import 'package:my_list_flutter/framework/view/splash_view.dart';

final injectSplashController = ChangeNotifierProvider((ref) =>
    SplashController(ProductRepositoryImp()));
final injectShoppingController = ChangeNotifierProvider((ref) =>
    ShoppingController(ShoppingRepositoryImp()));
final injectProductController = ChangeNotifierProvider((ref) =>
    ProductController(ProductRepositoryImp()));
final injectAddProductController = ChangeNotifierProvider((ref) =>
    AddProductController(CategoryRepositoryImp(), ProductRepositoryImp()));
final injectAddToDoController = ChangeNotifierProvider((ref) =>
    AddToDoController(ToDoTaskRepositoryImp()));

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

/// ----------------- MAIN -----------------------
///
///
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// CHAMAR DATABASE FLOOR
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final ProductDao dao = database.productDao;

  await configureLocalTimeZone();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // String initialRoute = "/";//HomePage.routeName;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails?.notificationResponse?.payload;
    // initialRoute =  "/principal";//SecondPage.routeName;
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
  <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );
  final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );

  try {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  } catch (e) {
    print(e);
  }

  /// --------- INICIAR VIEW COM INJEÇÃO DE DEPENDENCIA ----------------
  runApp(
      ProviderScope(child: MyApp(
        dao: dao,
        notificationAppLaunchDetails: notificationAppLaunchDetails
      ))
  );
}

class MyApp extends StatelessWidget {
  final ProductDao dao;
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  MyApp({super.key, required this.dao, this.notificationAppLaunchDetails});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
        initialRoute: "/",
        routes: {
          '/': (_) => const SplashView(),
          '/principal': (_) => MenuView(dao: dao, notificationAppLaunchDetails: notificationAppLaunchDetails),
          '/adicionarProduto': (_) => const AddProductView(),
          '/adicionarLembrete': (_) => const AddToDoAlert(),
        });
  }
}

