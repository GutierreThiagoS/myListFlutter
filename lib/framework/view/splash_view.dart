import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/custom_progress.dart';
import 'package:my_list_flutter/main.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        ref.read(injectSplashController).checkProduct(),
      ]).then((value) => Navigator.of(context).pushReplacementNamed("/principal"));
    });

    return Container(
      color: Colors.white,
      child: const CustomProgress(),
    );
  }
}
