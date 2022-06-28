import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController{
  final  RxList<Task>taskList = <Task>[].obs ;


 Future<int> addTasks({ Task? task}) {
    return DBHelper.insert(task);

  }
 Future<void> getTask() async {
   final List<Map<String, dynamic>> tasks= await DBHelper.query();
    taskList.assignAll(tasks.map((date) => Task.fromJson(date)).toList());
  }
  void deleteTask( Task? task) async {
  //  final List<Map<String, dynamic>> tasks= await DBHelper.query();
   await  DBHelper.delete(task);
   getTask();
  }
 void markUpCompleted(int id) async {
   // final List<Map<String, dynamic>> tasks= await DBHelper.query();
    await DBHelper.update(id);
    getTask();
  }
}

