import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/business_logic/todo_list_page_logic.dart';
import 'package:todo/logic/models/to_do_list_model.dart';
import 'package:todo/logic/models/to_do_task_model.dart';
import 'package:todo/logic/providers/to_do_lists_provider.dart';
import 'package:todo/screens/todo_list_page/local_ui/task_widget.dart';
import 'package:todo/ui/add_button.dart';
import 'package:todo/ui/global_constants.dart';

class TodoListPage extends StatefulWidget {
  final int id;
  ToDoListModel? model;
  TodoListPage({super.key, required this.id});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    var toDoList = context.watch<ToDoListsProvider>().getListById(widget.id);

    context.read<ToDoListsProvider>().changeSelectedList(toDoList?.id);

    print('one');
    print(widget.id);
    print('two');
    print(context.read<ToDoListsProvider>().selectedListId);
    return Scaffold(
      appBar: _buildAppBar(toDoList),
      body: _buildListView(toDoList),
      floatingActionButton: AddButton(
          onPressedFunction: (context) {
            ToDoListPageLogic.pressAddButton(context);
          },
          context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ListView _buildListView(ToDoListModel? toDoList) {
    return ListView.builder(
      itemCount: toDoList?.taskList.length ?? 0,
      itemBuilder: (context, index) {
        if (toDoList == null) return SizedBox.shrink();
        return TaskWidget(taskModel: toDoList.taskList[index]);
      },
    );
  }

  AppBar _buildAppBar(ToDoListModel? toDoList) {
    return AppBar(
      title: Text(
        toDoList?.name ?? 'Error',
        style: GoogleFonts.inter(
            color: SECONDARY_RED, fontSize: 40, fontWeight: FontWeight.w500),
      ),
      backgroundColor: PRIMARY_BROWN,
      leading: _buildAppBarBackButton(),
      actions: [
        _buildAppBarDeleteButton(),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  IconButton _buildAppBarDeleteButton() {
    return IconButton(
        onPressed: () {
          ToDoListPageLogic.pressListDeleteButton(context);
        },
        icon: Icon(
          Icons.delete,
          color: SECONDARY_RED,
          size: 32,
        ));
  }

  IconButton _buildAppBarBackButton() {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios_sharp,
        color: SECONDARY_RED,
        size: 32,
      ),
    );
  }
}
