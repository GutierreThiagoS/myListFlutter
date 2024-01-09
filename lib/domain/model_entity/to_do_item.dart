
import 'package:floor/floor.dart';

@entity
class ToDoItem {
  @PrimaryKey(autoGenerate: true) int? id;
  String title;
  String description;
  String dateCreate;
  String dateUpdate;
  String dateFinal;
  String hourAlert;
  String hourInitAlert;
  int dateHour;
  int level;
  int extendTimer;
  bool alert;
  bool concluded;
  bool deleted;

  ToDoItem({
    this.id,
    required this.title,
    required this.description,
    required this.dateCreate,
    required this.dateUpdate,
    required this.dateFinal,
    required this.hourAlert,
    required this.hourInitAlert,
    required this.dateHour,
    this.level = 1,
    this.extendTimer = 15,
    required this.alert,
    this.concluded = false,
    this.deleted = false
  });

  @override
  String toString() {
    return "ToDoItem { id: $id, title: $title }";
  }

}
