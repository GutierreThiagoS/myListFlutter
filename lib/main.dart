import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/controller/product_controller.dart';
import 'package:my_list_flutter/controller/shopping_controller.dart';
import 'package:my_list_flutter/controller/splash_controller.dart';
import 'package:my_list_flutter/data/repository/product_repository_imp.dart';
import 'package:my_list_flutter/data/repository/shopping_repository_imp.dart';
import 'package:my_list_flutter/framework/view/menu/menu_view.dart';
import 'package:my_list_flutter/framework/view/splash_view.dart';

final injectSplashController = ChangeNotifierProvider((ref) => SplashController(ProductRepositoryImp(null)));
final injectShoppingController = ChangeNotifierProvider((ref) => ShoppingController(ShoppingRepositoryImp(null)));
final injectProductController = ChangeNotifierProvider((ref) => ProductController(ProductRepositoryImp(null)));

Future<void> main() async {
  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          '/principal': (_) => const MenuView(),
        });
  }
}

