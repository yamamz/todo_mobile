import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_mobile/models/task_model.dart';
import 'package:todo_mobile/service/api_service.dart';

import '../../locator.dart';

class TasKViewModel extends BaseViewModel {
  final ApiService apiService = getIt<ApiService>();
  List<TaskModel> _tasks = <TaskModel>[];
  List<TaskModel> get tasks => _tasks;
  String _loadingMsg = 'Fetching todos';
  String get loadingMsg => _loadingMsg;
  String _dateSelected = DateFormat("MM/dd/yyyy").format(DateTime.now());
  String get dateSelected => _dateSelected;
  TextEditingController textEditingController = TextEditingController();

  Future<void> getTasks() async {
    setBusy(true);
    _loadingMsg = 'Fetching todos';
    _tasks = await apiService.getTasks();
    _tasks.sort((a, b) {
      final DateTime dateA = DateTime.parse(
          DateFormat("MM/dd/yyyy").parse(a.date).toIso8601String());
      final DateTime dateB = DateTime.parse(
          DateFormat("MM/dd/yyyy").parse(b.date).toIso8601String());
      return dateA.compareTo(dateB);
    });
    setBusy(false);
    notifyListeners();
  }

  void setDateSelected(String val) {
    _dateSelected = val;
    notifyListeners();
  }

  Future<void> addTodo() async {
    setBusy(true);
    _loadingMsg = 'Adding todo';
    TaskModel taskModel = await apiService.addTask(TaskModel(
        title: textEditingController.text,
        date: _dateSelected,
        completed: false));
    textEditingController.text = '';
    setBusy(false);
    _tasks.add(taskModel);
    _tasks.sort((a, b) {
      final DateTime dateA = DateTime.parse(
          DateFormat("MM/dd/yyyy").parse(a.date).toIso8601String());
      final DateTime dateB = DateTime.parse(
          DateFormat("MM/dd/yyyy").parse(b.date).toIso8601String());
      return dateA.compareTo(dateB);
    });
    notifyListeners();
  }

  Future<void> deleteTask(TaskModel taskModel) async {
    setBusy(true);
    _loadingMsg = 'Deleting todo';
    await apiService.deleteTask(taskModel.id.toString());
    setBusy(false);
    _tasks.remove(taskModel);
  }

  Future<void> setCompleted(bool value, index) async {
    _tasks[index].completed = value;
    setBusy(true);
    _loadingMsg = 'Updating todo';
    TaskModel taskModel =
        await apiService.updateTask(_tasks[index], _tasks[index].id.toString());
    setBusy(false);
    _tasks[index] = taskModel;
    notifyListeners();
  }
}
