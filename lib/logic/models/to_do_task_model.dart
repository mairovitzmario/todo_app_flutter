class ToDoTaskModel {
  String name = '';
  bool isCompleted = false;

  ToDoTaskModel({required this.name, this.isCompleted = false});

  void changeCompletion() {
    if (isCompleted == false) {
      isCompleted = true;
    } else {
      isCompleted = false;
    }
  }

  factory ToDoTaskModel.fromJson(Map<String, dynamic> json) => ToDoTaskModel(
        name: json['name'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'isCompleted': isCompleted,
      };
}
