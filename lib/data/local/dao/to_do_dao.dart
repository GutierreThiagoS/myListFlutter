
import 'package:floor/floor.dart';
import 'package:my_list_flutter/domain/model_entity/to_do_item.dart';

@dao
abstract class ToDoDao {

  @insert
  Future<int> insertToDo(ToDoItem toDoItem);

  @update
  Future<int> updateToDo(ToDoItem toDoItem);

  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> getAll();
  
  @Query('DELETE FROM ToDoItem')
  Future<void> deleteAll();
}