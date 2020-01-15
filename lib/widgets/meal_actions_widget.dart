import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/pages/edit_meal_page.dart';
import 'package:catmanager/widgets/bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MealActionsWidget extends StatefulWidget {
  MealActionsWidget({ @required this.meal });
  final Meal meal;
  _MealActionsWidgetState createState() => _MealActionsWidgetState();
}

class _MealActionsWidgetState extends State<MealActionsWidget> {

  String _formattedDateTime;

  @override
  void initState() {
    _formattedDateTime = DateFormat('HH:mm yyyy, MMM dd').format(widget.meal.datetime);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> headerList = [
      Text('${widget.meal.calories.toStringAsFixed(2)} kCal (${_formattedDateTime})'),
    ];

    return BlocBuilder<MealsListingBloc, MealsListingState>(
      builder: (BuildContext context, state) {
        if (state is MealsListingFetched) {
          return BottomSheetContainer(
              child: Wrap(
                children: <Widget>[
                  BottomSheetHeader(
                    child: Center(
                      child: Column(
                        children: headerList,
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text(widget.meal.isEaten ? 'Eaten down' : 'Eaten up'),
                    trailing: Icon(Icons.restaurant),
                    onTap: () {
                      widget.meal.isEaten = !widget.meal.isEaten;
                      BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(widget.meal, state.meals, () {
                        Navigator.of(context).pop();
                      }));
                    },
                  ),

                  ListTile(
                    title: Text('Edit'),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return EditMealPage(meal: widget.meal);
                          }
                      ));
                    },
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

          return Container( child: Text('Loading...'), );

        }
      }
    );





  }
}

