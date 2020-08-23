import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:todo_mobile/models/task_model.dart';
import 'package:todo_mobile/network/rest_client.dart';

@Injectable(env: Environment.prod)
class ApiService {
  final Dio dio = Dio();
  Future<List<TaskModel>> getTasks() async {
    final client = RestClient(dio);
    try {
      return client.getTasks();
    } catch (e) {
      print(e);
    }
    return <TaskModel>[];
  }

  Future<TaskModel> updateTask(TaskModel taskModel, String id) {
    final client = RestClient(dio);
    try {
      return client.updateTask(id, taskModel);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> deleteTask(String id) {
    final client = RestClient(dio);
    try {
      return client.deleteTask(id);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<TaskModel> addTask(TaskModel taskModel) {
    final client = RestClient(dio);
    try {
      return client.addTask(taskModel);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
