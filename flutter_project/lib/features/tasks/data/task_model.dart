// class TaskModel {
//   final int id;
//   final String todo;
//   final bool completed;
//
//   TaskModel({
//     required this.id,
//     required this.todo,
//     required this.completed,
//   });
//
//   factory TaskModel.fromJson(Map<String, dynamic> json) {
//     return TaskModel(
//       id: json['id'],
//       todo: json['todo'],
//       completed: json['completed'],
//     );
//   }
//
//   TaskModel copyWith({
//     int? id,
//     String? todo,
//     bool? completed,
//   }) {
//     return TaskModel(
//       id: id ?? this.id,
//       todo: todo ?? this.todo,
//       completed: completed ?? this.completed,
//     );
//   }
// }


class TaskModel {
  final int id;
  final String todo;
  final bool completed;
  final bool isLocal;

  TaskModel({
    required this.id,
    required this.todo,
    required this.completed,
    this.isLocal = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      isLocal: false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'todo': todo,
    'completed': completed,
    'isLocal': isLocal,
  };

  TaskModel copyWith({
    int? id,
    String? todo,
    bool? completed,
    bool? isLocal,
  }) {
    return TaskModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      isLocal: isLocal ?? this.isLocal,
    );
  }
}
