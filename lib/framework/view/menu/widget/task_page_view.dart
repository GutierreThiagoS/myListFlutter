import 'package:flutter/material.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';

class TaskPageView extends StatefulWidget {
  final List<ToDoItem> task;
  const TaskPageView({super.key, required this.task});

  @override
  State<TaskPageView> createState() => _TaskPageViewState();
}

class _TaskPageViewState extends State<TaskPageView> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, i) {
          return ListTile(
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            title: Card(
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.task[i].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(children: [
                                ElevatedButton(
                                    onPressed: () {
                                      // ref.read(injectAddProductController).clearProduct();
                                      Navigator.of(context).pushNamed("/adicionarLembrete",
                                          arguments: widget.task[i]);
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    },
                                    child: Row(children: [
                                      Text("Editar"),
                                      SizedBox(width: 8),
                                      Icon(Icons.edit_outlined)
                                    ])
                                )
                              ]),
                            ],
                          )
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.task[i].title,
                        style: TextStyle(
                            color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(widget.task[i].description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              "${widget.task[i].dateFinal} ${widget.task[i].hourInitAlert}",
                            style: TextStyle(
                              color: Colors.black45
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) =>  Container(),
        itemCount: widget.task.length
    );
  }
}
