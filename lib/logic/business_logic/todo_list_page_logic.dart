import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/models/to_do_task_model.dart';
import 'package:todo/logic/providers/to_do_lists_provider.dart';
import 'package:todo/screens/todo_list_page/local_ui/task_widget.dart';
import 'package:todo/ui/add_dialog.dart';
import '../database.dart';

import '../database.dart';
import '../models/to_do_list_model.dart';

class ToDoListPageLogic {
//Add button
  static void pressAddButton(BuildContext context) {
    showDialog(context: context, builder: (context) => AddDialog(page: 'list'));
  }

  static void pressListDeleteButton(BuildContext context) async {
    var id = context.read<ToDoListsProvider>().selectedListId;
    if (id == null) return;
    Navigator.of(context).pop();
    context.read<ToDoListsProvider>().removeList(id);

    var db = ToDoDatabase.instance;
    await db.deleteList(id);
  }

  static void pressTaskWidget(
      BuildContext context, ToDoTaskModel taskModel) async {
    context.read<ToDoListsProvider>().changeTaskCompletion(taskModel);

    var db = ToDoDatabase.instance;
    var listId = context.read<ToDoListsProvider>().selectedListId;
    if (listId == null) return;
    var selectedList = context.read<ToDoListsProvider>().getListById(listId);
    if (selectedList == null) return;
    print(listId);

    if (listId != null) {
      await db.updateList(listId, selectedList);
    }
  }

  static void pressTaskDeleteButton(
      BuildContext context, ToDoTaskModel taskModel) async {
    int? selectedListId = context.read<ToDoListsProvider>().selectedListId;

    if (selectedListId == null) {
      return;
    }

    context
        .read<ToDoListsProvider>()
        .removeTaskFromList(selectedListId, taskModel);
    var selectedList =
        context.read<ToDoListsProvider>().getListById(selectedListId);

    if (selectedList == null) return;

    var db = ToDoDatabase.instance;
    await db.updateList(selectedListId, selectedList);
  }

  static void pressConfirmDialog(BuildContext context,
      TextEditingController controller, String defaultText) async {
    late String taskName;
    int? selectedListId = context.read<ToDoListsProvider>().selectedListId;

    if (selectedListId == null) {
      return;
    }

    var selectedList =
        context.read<ToDoListsProvider>().getListById(selectedListId);

    if (selectedList == null) return;

    if (controller.text.isEmpty) {
      taskName = defaultText;
    } else {
      taskName = controller.text;
    }

    var db = ToDoDatabase.instance;
    await db.updateList(selectedListId, selectedList);

    context.read<ToDoListsProvider>().addTaskToList(selectedListId, taskName);

    Navigator.of(context).pop();
  }
}
