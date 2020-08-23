import 'package:flutter/material.dart';
import 'package:todo_mobile/ultils/date_util.dart';

class NextAppointmentDate extends StatelessWidget {
  final DateTime selectedDate;
  const NextAppointmentDate({Key key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                getDayNumberString(selectedDate),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
              ),
              Text(
                getMonthAbbrString(selectedDate),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(
                getYearAbbrString(selectedDate),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12.0),
              )
            ],
          ),
          const SizedBox(width: 8.0),
          Container(
            margin: const EdgeInsets.only(top: 6),
            color: Theme.of(context).primaryColor,
            height: 70.0,
            width: 6.0,
          ),
        ],
      ),
    );
  }
}
