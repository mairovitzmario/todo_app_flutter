import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/business_logic/home_page_logic.dart';
import 'package:todo/logic/models/to_do_task_model.dart';
import 'package:todo/logic/providers/to_do_lists_provider.dart';
import '../../../logic/business_logic/todo_list_page_logic.dart';
import 'package:todo/ui/global_constants.dart';

class TaskWidget extends StatelessWidget {
  final ToDoTaskModel taskModel;

  const TaskWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var completedColor = const Color.fromARGB(255, 0, 143, 5);
    var checkedIcon = taskModel.isCompleted == true
        ? Icons.check_box_outlined
        : Icons.check_box_outline_blank;

    return Card(
      elevation: 0,
      color: PRIMARY_BROWN,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          checkedIcon,
          color: taskModel.isCompleted ? completedColor : SECONDARY_RED,
          size: 28,
        ),
        title: Text(
          taskModel.name,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: taskModel.isCompleted ? completedColor : SECONDARY_RED,
            decoration: taskModel.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: completedColor,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: SECONDARY_RED),
          onPressed: () {
            ToDoListPageLogic.pressTaskDeleteButton(context, taskModel);
          },
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        onTap: () {
          ToDoListPageLogic.pressTaskWidget(context, taskModel);
        },
      ),
    );
  }
}
