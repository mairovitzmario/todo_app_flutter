import 'package:flutter/material.dart';
import 'package:todo/logic/models/to_do_list_model.dart';
import 'package:todo/logic/models/to_do_task_model.dart';
import '../../screens/home_page/local_ui/todo_list_card.dart';
import '../database.dart';

class ToDoListsProvider extends ChangeNotifier {
  List<ToDoListModel> toDoLists = [];
  int? selectedListId;

  ToDoListsProvider(this.toDoLists) {
    notifyListeners();
  }

  ToDoListsProvider.db() {
    _initializeFromDatabase();
  }

  Future<void> _initializeFromDatabase() async {
    var db = ToDoDatabase.instance;
    toDoLists = await db.getAllToDoLists();
    notifyListeners();
  }

  ToDoListModel? getListById(int id) {
    for (int i = 0; i < toDoLists.length; i++) {
      if (toDoLists[i].id == id) return toDoLists[i];
    }
    return null;
  }

  void changeSelectedList(int? newSelectedListId) {
    selectedListId = newSelectedListId;
  }

  void addList(ToDoListModel newList) {
    toDoLists.add(newList);
    notifyListeners();
  }

  void removeList(int id) {
    toDoLists.remove(getListById(id));
    notifyListeners();
  }

  void addTaskToList(int id, String taskName) {
    var toDoList = getListById(id);

    if (toDoList == null) return;

    toDoList.taskList.add(ToDoTaskModel(name: taskName));

    notifyListeners();
  }

  void removeTaskFromList(int id, ToDoTaskModel task) {
    var toDoList = getListById(id);

    if (toDoList == null) return;

    toDoList.taskList.remove(task);

    notifyListeners();
  }

  void changeTaskCompletion(ToDoTaskModel task) {
    if (task.isCompleted == true) {
      task.isCompleted = false;
    } else {
      task.isCompleted = true;
    }
    notifyListeners();
  }
}
