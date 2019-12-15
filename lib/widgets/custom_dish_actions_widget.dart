import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/pages/create_custom_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CustomDishActionsWidget extends StatefulWidget {
  CustomDishActionsWidget({ @required this.dish });
  final CustomDish dish;
  _CustomDishActionsWidgetState createState() => _CustomDishActionsWidgetState();
}

class _CustomDishActionsWidgetState extends State<CustomDishActionsWidget> {

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
                  Text('${widget.dish.calories.toString()}kCal', style: TextStyle(color: Colors.white)),
                  Text('${widget.dish.datetime.toIso8601String()}', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            color: Colors.blue,
          ),
          ListTile(
            title: Text('Edit'),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CreateDishPage(
                      customDish: widget.dish,
                    );
                  }
              ));

            },
          ),
          ListTile(
            title: Text('Remove', style: TextStyle(color: Colors.red),),
            trailing: Icon(Icons.close, color: Colors.redAccent),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete custom dish?'),
//                    semanticLabel: '11111111 2123',
//                    content: Container(
//                      child: Column(
//                        children: <Widget>[
//                          Text('${widget.dish.getCalorieContent().toString()}kCal/100g'),
//                          Text('Total calories: ${widget.dish.calories.toString()}kCal/100g'),
//                          Text('Result weight ${widget.dish.getFinalWeight()}g'),
//                          Text('Pan weight ${widget.dish.panWeight}g'),
//                          Text('With pan weight ${widget.dish.weight}g'),
//                        ],
//                      ),
//                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          BlocProvider.of<CustomDishListingBloc>(context).add(CustomDishDeletingEvent(widget.dish));
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }
              );
            },
          ),
        ],
      )
    );
  }
}

