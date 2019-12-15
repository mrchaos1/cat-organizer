import 'dart:async';

import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class MealActionsWidget extends StatefulWidget {
  MealActionsWidget({ @required this.meal });
  final Meal meal;
  _MealActionsWidgetState createState() => _MealActionsWidgetState();
}

class _MealActionsWidgetState extends State<MealActionsWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  Text('${widget.meal.calories.toString()}kCal', style: TextStyle(color: Colors.white)),
                  Text('${widget.meal.datetime.toIso8601String()}', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            color: Colors.blue,
          ),
          ListTile(
            title: Text('Remove', style: TextStyle(color: Colors.red),),
            trailing: Icon(Icons.close, color: Colors.redAccent),
            onTap: () {
                BlocProvider.of<MealsListingBloc>(context).add(MealDeletingEvent(widget.meal));
                Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }
}

