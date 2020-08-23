import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_mobile/constants/color_constant.dart';
import 'package:todo_mobile/views/view_models/task_view_model.dart';
import 'package:todo_mobile/views/widgets/next_appointment_date_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasKViewModel>.reactive(
      viewModelBuilder: () => TasKViewModel(),
      onModelReady: (model) => model.getTasks(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showAddTodo(context, model);
                }),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  model.getTasks();
                })
          ],
          title: Text(
            'Todos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: model.tasks.length,
              itemBuilder: (context, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.15,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: primaryColor,
                      icon: Icons.delete,
                      onTap: () {
                        model.deleteTask(model.tasks[index]);
                      },
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              NextAppointmentDate(
                                selectedDate: DateTime.parse(
                                  DateFormat("MM/dd/yyyy")
                                      .parse(model.tasks[index].date)
                                      .toIso8601String(),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: Text(
                                model.tasks[index].title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                              SizedBox(
                                width: 8,
                              ),
                              RaisedButton(
                                color: model.tasks[index].completed
                                    ? Colors.indigo[100]
                                    : primaryButtonColor,
                                onPressed: () {
                                  model.setCompleted(
                                      !model.tasks[index].completed, index);
                                },
                                child: Text(
                                  model.tasks[index].completed
                                      ? 'completed'
                                      : 'active',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                );
              },
            ),
            if (model.isBusy)
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: Center(
                  child: Container(
                      child: Column(children: [
                    CircularProgressIndicator(),
                    Text(model.loadingMsg)
                  ])),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Show add todo
  Future<bool> showAddTodo(BuildContext context, TasKViewModel model) {
    return Alert(
        context: context,
        title: "Add Todo",
        content: Column(
          children: <Widget>[
            TextField(
              controller: model.textEditingController,
              decoration: InputDecoration(hintText: 'Enter todo title'),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light(),
                            child: child,
                          );
                        },
                      );
                      final String dateFormat = DateFormat("MM/dd/yyyy")
                          .format(dateTime ?? DateTime.now());

                      model.setDateSelected(dateFormat);
                    }),
                Text(model.dateSelected)
              ],
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              model.addTodo();
              Navigator.pop(context);
            },
            child: Text(
              "add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
