import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/custom_progress.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';
import 'package:my_list_flutter/framework/view/menu/widget/task_page_view.dart';

class ToDoListPage extends ConsumerStatefulWidget {
  final ProductDao dao;
  const ToDoListPage({super.key, required this.dao});

  @override
  ConsumerState<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends ConsumerState<ToDoListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: StreamBuilder<List<ToDoItem>>(
            stream: widget.dao.getAllTodoAsync(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return CustomProgress();
              final data = snapshot.requireData;
              print(data);
              if(data.isNotEmpty) {
                return TaskPageView(task: data);
              } else {
                return Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/adicionarLembrete");
                      },
                      child: Text("Adicione um lembrente")
                  ),
                );
              }
            },
          )
    );
  }
}

