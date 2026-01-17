import 'dart:convert';
import '../../../core/storage/local_storage.dart';
import '../networking/task_networking.dart';
import 'task_model.dart';

class TaskRepository {
  final TaskNetworking api;
  final LocalStorage local;

  TaskRepository(this.api, this.local);

  Future<List<TaskModel>> getTasks(int limit, int skip) async {
    try {
      final res = await api.fetchTasks(limit, skip);
      local.saveTasks(jsonEncode(res['todos']));
      return (res['todos'] as List).map((e) => TaskModel.fromJson(e)).toList();
    } catch (_) {
      final cached = await local.getTasks();
      if (cached != null) return (jsonDecode(cached) as List).map((e) => TaskModel.fromJson(e)).toList();
      rethrow;
    }
  }


  Future<TaskModel> addTask(String title) {
    return api.addTask(title);
  }


  Future<TaskModel> updateTask(TaskModel task) async {
    final response = await api.updateTask(
      id: task.id,
      todo: task.todo,
      completed: task.completed,
    );

    return TaskModel.fromJson(response);
  }


  Future<void> deleteTask(int id) => api.deleteTask(id);
}
