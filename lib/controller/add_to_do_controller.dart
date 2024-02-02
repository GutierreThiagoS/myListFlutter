
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';
import 'package:my_list_flutter/domain/repository/to_do_task_repository.dart';
import 'package:my_list_flutter/framework/utils/date_convert.dart';

class AddToDoController extends ChangeNotifier {

  final ToDoTaskRepository _toDoTaskRepository;

  AddToDoController(this._toDoTaskRepository);

  String _title = "";
  String get title => _title;
  setTitle(String value) => _title = value;

  String _description = "";
  String get description => _description;
  setDescription(String value) => _description = value;

  String _dateFinal = "";
  String get dateFinal => _dateFinal;
  setDateFinal(String value) {
    _dateFinal = formatDateNumber(value);
  }

  String _hourInitAlert = "";
  String get hourInitAlert => _hourInitAlert;
  setHourInitAlert(String value) {
    _hourInitAlert = formatHourNumber(value);
  }

  Future<bool> saveToDoTask(ToDoItem? task) async {
    DateTime agora = DateTime.now();

    var dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    var dateFormat2 = DateFormat('yyyyMMddHHmm');
    var parseDateFinal = dateFormat.parse("$_dateFinal $hourInitAlert");
    var dateFinalFormat = dateFormat2.format(parseDateFinal);
    var dateFinal = int.tryParse(dateFinalFormat);
    String dateToday = dateFormat.format(agora);
    print("_dateFinal $_dateFinal");
    print(dateFormat.format(agora));
    print(dateFormat2.format(agora));
    print("parseDateFinal $parseDateFinal");
    print("dateFinalFormat $dateFinalFormat");

    if(_description.isNotEmpty &&
        _title.isNotEmpty &&
        _dateFinal.isNotEmpty &&
        dateFinal != null
    ) {
      print("ProductInItemShopping? $task");
      return  await _toDoTaskRepository.saveToDoItem(
          ToDoItem(
              id: task?.id,
              title: _title,
              description: _description,
              dateCreate: task?.dateCreate?? dateToday,
              dateUpdate: dateToday,
              dateFinal: _dateFinal,
              hourAlert: _hourInitAlert,
              hourInitAlert: _hourInitAlert,
              dateHour: dateFinal,
              alert: false,
          )
      );
    } else {
      return false;
    }
  }

  void clearToDoList() {
    _title = "";
    _description = "";
    _dateFinal = "";
    _hourInitAlert = "";
  }
}