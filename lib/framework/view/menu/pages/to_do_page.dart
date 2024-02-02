import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/components/custom_progress.dart';
import 'package:my_list_flutter/data/local/dao/product_dao.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';
import 'package:my_list_flutter/framework/view/menu/widget/task_page_view.dart';
import 'package:my_list_flutter/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
        child: Column(
          children: [
          ToggleSwitch(
            minWidth: double.infinity,
            minHeight: 40.0,
            initialLabelIndex: 0,
            cornerRadius: 10.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 3,
            labels: ['Todos', 'Alert', 'Deletado'],
            icons: [
              Icons.filter_list,
              Icons.timer,
              Icons.delete_sweep_outlined
            ],
            iconSize: 30.0,
            radiusStyle: true,
            borderColor: [Color(0xff3b5998), Color(0xff8b9dc3), Color(0xff00aeff), Color(0xff0077f2), Color(0xff962fbf), Color(0xff4f5bd5)],
            dividerColor: Colors.blueGrey,
            activeBgColors: [ [Color(0xfffeda75), Color(0xfffa7e1e), Color(0xffd62976), Color(0xff962fbf), Color(0xff4f5bd5)], [Color(0xff00aeff), Color(0xff0077f2)], [Color(0xff3b5998), Color(0xff8b9dc3)]],
            onToggle: (index) {
              print('switched to: $index');
            },
        ),
            StreamBuilder<List<ToDoItem>>(
                stream: widget.dao.getAllTodoAsync(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return const CustomProgress();
                  final data = snapshot.requireData;
                  print(data);
                  if(data.isNotEmpty) {
                    return TaskPageView(task: data, refresh: () {
                      setState(() {
                        print('TaskPageView refresh');
                      });
                    });
                  } else {
                    return Center(
                      child: ElevatedButton(
                          onPressed: () {
                            ref.read(injectAddToDoController).clearToDoList();
                            Navigator.of(context).pushNamed("/adicionarLembrete").then((value) {
                              setState(() {
                                print("$value teste");
                              });
                            });
                          },
                          child: const Text("Adicione um lembrente")
                      ),
                    );
                  }
                },
              ),
          ],
        )
    );
  }
}

