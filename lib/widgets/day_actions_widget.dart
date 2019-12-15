import 'package:catmanager/blocs/days_listring_bloc.dart';
import 'package:catmanager/events/days_listing_event.dart';
import 'package:catmanager/models/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayActionsWidget extends StatefulWidget {
  DayActionsWidget({ @required this.day });
  final Day day;
  _DayActionsWidgetState createState() => _DayActionsWidgetState();
}

class _DayActionsWidgetState extends State<DayActionsWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: new Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('${widget.day.calories.toString()}kCal', style: TextStyle(color: Colors.white)),
                  Text('${widget.day.startDatetime.toIso8601String()}', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            color: Colors.blue,
          ),
          ListTile(
            title: Text('Remove', style: TextStyle(color: Colors.red),),
            trailing: Icon(Icons.close, color: Colors.redAccent),
            onTap: () {
              BlocProvider.of<DaysListingBloc>(context).add(DayDeletingEvent(widget.day));
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }
}

