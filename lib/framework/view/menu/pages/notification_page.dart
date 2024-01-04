import 'package:flutter/material.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';

class NotificationPage extends StatefulWidget {
  final ProductDao dao;
  const NotificationPage({super.key, required this.dao});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

