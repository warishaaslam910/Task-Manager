import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveTasks(String tasksJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', tasksJson);
  }

  Future<String?> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('tasks');
  }
}
