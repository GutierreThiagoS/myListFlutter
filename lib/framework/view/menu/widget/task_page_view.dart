import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';
import 'package:my_list_flutter/framework/config_notification/config_notificationn.dart';
import 'package:my_list_flutter/framework/utils/date_convert.dart';
import 'package:my_list_flutter/main.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class TaskPageView extends ConsumerStatefulWidget {
  final List<ToDoItem> task;
  final Function() refresh;
  const TaskPageView({super.key, required this.task, required this.refresh});

  @override
  ConsumerState<TaskPageView> createState() => _TaskPageViewState();
}

class _TaskPageViewState extends ConsumerState<TaskPageView> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, i) {
          ToDoItem task = widget.task[i];
          if(!task.concluded && !task.deleted) {
            tz.initializeTimeZones();
            String dateTime = getFormattedDateFromFormattedString(
                "${task.dateFinal} ${task.hourAlert}");
            final tz.TZDateTime dataTime = tz.TZDateTime.parse(tz.local, dateTime);
            if(!dataTime.isBefore(tz.TZDateTime.now(tz.local))) {
              scheduleDailyTenAMNotification(dateTime, task.title, task.description);
            }
          }
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            title: Card(
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.task[i].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(children: [
                                ElevatedButton(
                                    onPressed: () {
                                      ref.read(injectAddToDoController).clearToDoList();
                                      Navigator.of(context).pushNamed("/adicionarLembrete",
                                          arguments: widget.task[i]).then((value) {
                                        setState(() {
                                          print("$value teste adicionarLembrete click");
                                          widget.refresh();
                                        });
                                      });
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    },
                                    child: const Row(children: [
                                      Text("Editar"),
                                      SizedBox(width: 8),
                                      Icon(Icons.edit_outlined)
                                    ])
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                      showNotification(widget.task[i].title, widget.task[i].description);
                                    },
                                    child: const Row(children: [
                                      Text("Ativar Notification"),
                                      SizedBox(width: 8),
                                      Icon(Icons.edit_outlined)
                                    ])
                                )
                              ]),
                            ],
                          )
                      )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.task[i].title,
                        style: const TextStyle(
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
                            style: const TextStyle(
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
