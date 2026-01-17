import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../data/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasks();
  }

  // ===================== ADD TASK =====================
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(
            hintText: 'Enter task title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _taskController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = _taskController.text.trim();

              if (title.isNotEmpty) {
                context.read<TaskCubit>().addTask(title);
              }

              _taskController.clear();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // ===================== EDIT TASK =====================
  void _showEditTaskDialog(TaskModel task) {
    final controller = TextEditingController(text: task.todo);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Edit task title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedTitle = controller.text.trim();

              if (updatedTitle.isNotEmpty) {
                context.read<TaskCubit>().updateTask(
                  task.copyWith(todo: updatedTitle),
                );
              }

              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (_, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text('No tasks yet'));
            }

            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (_, i) {
                final task = state.tasks[i];

                return ListTile(
                  title: Text(
                    task.todo,
                    style: TextStyle(
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  // ---------- TOGGLE ----------
                  leading: Checkbox(
                    value: task.completed,
                    onChanged: (_) {
                      context.read<TaskCubit>().updateTask(
                        task.copyWith(
                          completed: !task.completed,
                        ),
                      );
                    },
                  ),

                  // ---------- EDIT + DELETE ----------
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditTaskDialog(task),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            context.read<TaskCubit>().deleteTask(task.id),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          if (state is TaskError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}








