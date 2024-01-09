

import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';

abstract class ToDoTaskRepository {

  Future<bool> saveToDoItem(ToDoItem item);

}