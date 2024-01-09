import 'package:flutter/material.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final ProductDao dao = database.productDao;

  runApp(
      ProviderScope(child: MyApp(dao: dao))
  );
}

class MyApp extends StatelessWidget {
  final ProductDao dao;
  MyApp({super.key, required this.dao});

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
          '/principal': (_) => MenuView(dao: dao),
          '/adicionarProduto': (_) => const AddProductView(),
          '/adicionarLembrete': (_) => const AddToDoAlert(),
        });
  }
}

