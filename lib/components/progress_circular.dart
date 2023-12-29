import 'package:flutter/material.dart';

class ProgressCircular extends StatelessWidget {
  const ProgressCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [CircularProgressIndicator()],
      ),
    );
  }
}
