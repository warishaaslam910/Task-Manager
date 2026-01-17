import '../../../core/networking/api_networking.dart';
import '../data/task_model.dart';

class TaskNetworking {
  final ApiNetworking networking;
  int _lastId = 1000; // start from a safe number > existing DummyJSON IDs

  TaskNetworking(this.networking);

  Future<Map<String, dynamic>> fetchTasks(int limit, int skip) async {
    final res = await networking.get('/todos', query: {'limit': limit, 'skip': skip});
    return res.data;
  }



  Future<TaskModel> addTask(String title) async {
    final response = await networking.post(
      '/todos/add',
      data: {
        'todo': title,
        'completed': false,
        'userId': 5,
      },
    );

    final taskFromApi = TaskModel.fromJson(response.data);

    // Increment lastId for new task
    _lastId++;

    return taskFromApi.copyWith(id: _lastId);
  }



  Future<Map<String, dynamic>> updateTask({
    required int id,
    required String todo,
    required bool completed,
  }) async {
    final response = await networking.put(
      '/todos/$id',
      data: {
        'todo': todo,
        'completed': completed,
      },
    );

    return response.data;
  }

  Future<void> deleteTask(int id) async {
    await networking.delete('/todos/$id');
  }
}
