import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/task_repository.dart';
import '../data/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repo;

  int skip = 0;
  final int limit = 10;
  bool hasMore = true;
  List<TaskModel> tasks = [];

  TaskCubit(this.repo) : super(TaskLoading());

  Future<void> loadTasks() async {
    if (!hasMore) return;
    emit(TaskLoading());
    try {
      final newTasks = await repo.getTasks(limit, skip);
      tasks.addAll(newTasks);
      skip += limit;
      hasMore = newTasks.length == limit;
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }


  Future<void> addTask(String title) async {
    if (state is TaskLoaded) {
      final currentTasks = (state as TaskLoaded).tasks;

      // 1️⃣ API returns the created task
      final newTask = await repo.addTask(title);

      // 2️⃣ Add locally (top of list)
      final updatedTasks = [newTask, ...currentTasks];

      // 3️⃣ Emit updated state
      emit(TaskLoaded(updatedTasks));
    }
  }




  Future<void> updateTask(TaskModel updatedTask) async {
    if (state is TaskLoaded) {
      final currentTasks = (state as TaskLoaded).tasks;

      // Call API
      final apiUpdatedTask = await repo.updateTask(updatedTask);

      // Replace task locally
      final updatedList = currentTasks.map((task) {
        return task.id == apiUpdatedTask.id ? apiUpdatedTask : task;
      }).toList();

      emit(TaskLoaded(updatedList));
    }
  }




  //
  // Future<void> deleteTask(int id) async {
  //   await repo.deleteTask(id);
  //   reset();
  // }

  Future<void> deleteTask(int id) async {
    if (state is TaskLoaded) {
      final currentTasks = (state as TaskLoaded).tasks;

      // 1️⃣ Remove locally
      final updatedTasks =
      currentTasks.where((task) => task.id != id).toList();

      // 2️⃣ Emit updated state
      emit(TaskLoaded(updatedTasks));

      // 3️⃣ Call API (mock)
      await repo.deleteTask(id);
    }
  }


  void reset() {
    skip = 0;
    hasMore = true;
    tasks.clear();
    loadTasks();
  }
}
