import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    Key key,
    @required this.dateTime,
    TextStyle textStyle
  }) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(DateFormat("HH:mm yyyy, MMM dd").format(dateTime));
  }
}