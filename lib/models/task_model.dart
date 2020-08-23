class TaskModel {
  String title;
  String date;
  bool completed;
  int id;

  TaskModel({this.title, this.date, this.completed, int id});

  TaskModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    completed = json['completed'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['completed'] = this.completed;
    data['id'] = this.id;
    return data;
  }
}
