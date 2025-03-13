import 'package:get/get.dart';

import '../../../../core/Model/task_model.dart';
import '../../../../core/db/db_hellper.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  getTasks() async {
    final List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList
        .assignAll(tasks.map((taskData) => Task.fromMap(taskData)).toList());
  }

  Future<int> addTask({required Task task}) {
    var intReturned = DbHelper.insert(task);
    return intReturned;
  }

  deleteTask({required Task task}) async {
    await DbHelper.delete(task);
    getTasks();
  }

  deleteAllTasks() async {
    await DbHelper.deleteAll();
    getTasks();
  }

  setTaskAsCompleted({required int taskId}) async {
    await DbHelper.update(taskId);
    getTasks();
  }
}
