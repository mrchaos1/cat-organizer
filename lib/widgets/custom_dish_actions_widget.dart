import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/pages/create_custom_dish_page.dart';
import 'package:catmanager/widgets/bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class CustomDishActionsWidget extends StatefulWidget {
  CustomDishActionsWidget({ @required this.dish });
  final CustomDish dish;
  _CustomDishActionsWidgetState createState() => _CustomDishActionsWidgetState();
}

class _CustomDishActionsWidgetState extends State<CustomDishActionsWidget> {
  String _formattedDateTime;

  @override
  void initState() {
    super.initState();
    _formattedDateTime = DateFormat('HH:mm yyyy, MMM dd').format(widget.dish.datetime);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BottomSheetContainer(
      child: Wrap(
        children: <Widget>[
          BottomSheetHeader(
            child: Text('${widget.dish.calories.toString()} kCal (${_formattedDateTime})', textAlign: TextAlign.center,),
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
                    title: Text('Delete custom dish?', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal)),
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

