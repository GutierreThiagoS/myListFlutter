import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';
import 'package:my_list_flutter/framework/utils/text.dart';
import 'package:my_list_flutter/main.dart';
import 'package:my_list_flutter/widget/custom_outlined_button_widget.dart';
import 'package:my_list_flutter/widget/custom_text_field_widget.dart';

class AddToDoAlert extends ConsumerStatefulWidget {
  const AddToDoAlert({super.key});

  @override
  ConsumerState<AddToDoAlert> createState() => _AddToDoAlertState();
}

class _AddToDoAlertState extends ConsumerState<AddToDoAlert> {

  @override
  Widget build(BuildContext context) {

    ToDoItem? task = ModalRoute
        .of(context)!
        .settings
        .arguments as ToDoItem?;

    if (task != null && ref.read(injectAddToDoController).title.isEmpty) {
      print("task $task");
      final controller = ref.read(injectAddToDoController);
      controller.setTitle(task.title);
      controller.setDescription(task.description);
      controller.setDateFinal(task.dateFinal);
      controller.setHourInitAlert(task.hourInitAlert);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${task != null ? "Edite": "Registre"} seu Lembrete",
          style:
          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.black12,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(15),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldWidget(
                    controller: getController(ref.read(injectAddToDoController).title),
                    onChange:
                    ref.read(injectAddToDoController).setTitle,
                    label: "Titulo",
                    prefixIcon: Icons.title,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  CustomTextFieldWidget(
                    onChange: ref.read(injectAddToDoController).setDescription,
                    label: "Descrição",
                    controller: getController(ref.read(injectAddToDoController).description),
                    prefixIcon: Icons.receipt_long,
                    minLines: 4,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  CustomTextFieldWidget(
                    controller: getController(
                        ref.read(injectAddToDoController).dateFinal),
                    onChange: (value) {
                      setState(() {
                        ref.read(injectAddToDoController).setDateFinal(value);
                      });
                    },
                    label: "Data do Alarme",
                    prefixIcon: Icons.edit_calendar_outlined,
                      onPressedPrefixIcon: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((pickedDate) {
                          if (pickedDate != null) {
                            setState(() {
                              String dateFormat = DateFormat('dd/MM/yyyy').format(pickedDate);
                              ref.read(injectAddToDoController).setDateFinal(dateFormat);
                            });
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                    cursorEnd: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  CustomTextFieldWidget(
                      controller: getController(ref.read(injectAddToDoController).hourInitAlert),
                      onChange: (value) {
                        setState(() {
                          ref.read(injectAddToDoController).setHourInitAlert(value);
                        });
                      },
                      label: "Hora do Alarme",
                      prefixIcon: Icons.access_time_outlined,
                      onPressedPrefixIcon: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((picked) {
                          if (picked != null) {
                            String hour = picked.hour.toString();
                            String minute = picked.minute.toString();
                            print("hour ${picked.hour}, minute $minute");
                            setState(() {
                              ref.read(injectAddToDoController)
                                  .setHourInitAlert("${hour.padLeft(2, '0')}:${minute.padLeft(2, '0')}");
                            });
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                    cursorEnd: true,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomOutlinedButton(
                        onPressed: () {
                          ref.read(injectAddToDoController).saveToDoTask(task).then((status) {
                            if(status) {
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        text: "Adicionar",
                        iconData: Icons.save_rounded
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
