import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/modals/meal_actions_modal.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/pages/edit_meal_page.dart';
import 'package:catmanager/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MealsPage extends StatefulWidget {
  MealsPage({Key key}) : super(key: key);
  @override
  _MealsPageState createState() => _MealsPageState();
}


class _MealsPageState extends State<MealsPage> {

  List<Meal> _meals;

  @override
  void initState() {
    super.initState();
  }


  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final Meal item = _meals.removeAt(oldIndex);
    _meals.insert(newIndex, item);

    BlocProvider.of<MealsListingBloc>(context).add(MealsResortingEvent(_meals));
  }


  @override
  Widget build(BuildContext context) {

    BlocProvider.of<MealsListingBloc>(context).add(MealsFetchEvent());
    
    return Scaffold(
      body: Container(

        child: BlocBuilder<MealsListingBloc, MealsListingState>(
          builder: (BuildContext context, state) {
            if (state is MealsListingLoading) {

              return Center(child: CircularProgressIndicator(strokeWidth: 2.0));

            } else if (state is MealsListingFetched) {

              List<Meal> items = state.meals.toList();
              _meals = items;


              return ReorderableListView(
                onReorder: _onReorder,
                children: items.map((Meal meal) => Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                    onDismissed: (actionType) => BlocProvider.of<MealsListingBloc>(context).add(MealDeletingEvent(meal)),
                  ),

                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EditMealPage(meal: meal);
                            }
                        ));
                      },
                    ),
                  ],

                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Remove',
                      color: Colors.red,
                      icon: Icons.close,
                      onTap: () => BlocProvider.of<MealsListingBloc>(context).add(MealDeletingEvent(meal)),
                    ),

                  ],

                  key: Key(meal.id.toString()),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 3.0, color: meal.isEaten ? Colors.red : Colors.grey),
                      ),
                    ),
                  child: GestureDetector(
                    onTap: () => MealActionsModal.showModal(context, meal),
                    onDoubleTap: () {
                      print(meal.eatenDatetime);
                      meal.eatenDatetime = meal.isEaten ? null : DateTime.now();
                      BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(meal, state.meals, () {

                      }));
                    },
                    child: ListTile(
                      trailing: meal.eatenDatetime == null ? null : DateTimeWidget(dateTime: meal.eatenDatetime,),
                      title: Text('+ ${meal.calories.toStringAsFixed(2)} kCal', style: TextStyle(fontWeight: FontWeight.w500, color: meal.isEaten ? null : Theme.of(context).disabledColor,)),
                      subtitle: meal.description == null ? null : Text(meal.description),
                    )
                  )))).toList(),
              );
            }
            return Center(child: Text('Unknown state'));
          }
        )
      ),
    );
  }
}
