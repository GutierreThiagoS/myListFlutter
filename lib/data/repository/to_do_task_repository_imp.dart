
import 'package:my_list_flutter/data/local/database.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';
import 'package:my_list_flutter/domain/repository/to_do_task_repository.dart';

class ToDoTaskRepositoryImp implements ToDoTaskRepository {

  @override
  Future<bool> saveToDoItem(ToDoItem item) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final todoDao = database.todoDao;
      print(item);
      if(item.id == null) {
        final up = await todoDao.insertToDo(item);
        return up > 0;
      } else {
        final up = await todoDao.updateToDo(item);
        return up > 0;
      }
    } catch(e) {
      print("e");
      return false;
    }
  }

}