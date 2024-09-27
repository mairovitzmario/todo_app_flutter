import 'dart:convert';
import 'to_do_task_model.dart';

class ToDoListModel {
  int? id; // Nullable id field for database
  String name;
  DateTime date;
  List<ToDoTaskModel> taskList;

  ToDoListModel({
    this.id,
    required this.name,
    DateTime? date,
    List<ToDoTaskModel>? taskList,
  })  : date = date ?? DateTime.now(),
        taskList = taskList ?? [];

  // Method to create a new instance with updated fields
  ToDoListModel copy({
    int? id,
    String? name,
    DateTime? date,
    List<ToDoTaskModel>? taskList,
  }) {
    return ToDoListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      taskList: taskList ?? this.taskList,
    );
  }

  // Serialize the model to a Map for database storage
  Map<String, Object?> serializeModel() {
    return {
      'id': id,
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'list': jsonEncode(taskList.map((task) => task.toJson()).toList()),
    };
  }

  // Deserialize the model from a Map
  factory ToDoListModel.fromJson(Map<String, dynamic> json) {
    return ToDoListModel(
      id: json['id'] as int,
      name: json['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
      taskList: json['list'] != null
          ? (jsonDecode(json['list'] as String) as List<dynamic>)
              .map((taskJson) =>
                  ToDoTaskModel.fromJson(taskJson as Map<String, dynamic>))
              .toList()
          : [], // Provide an empty list if 'list' is null
    );
  }

  int getFinishedTasksCount() {
    int sum = 0;
    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].isCompleted == true) {
        sum += 1;
      }
    }
    return sum;
  }
}
