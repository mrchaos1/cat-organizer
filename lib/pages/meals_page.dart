import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/modals/create_meal_modal.dart';
import 'package:catmanager/modals/meal_actions_modal.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/widgets/create_meal_widget.dart';
import 'package:catmanager/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';

class MealsPage extends StatefulWidget {
  MealsPage({Key key}) : super(key: key);
  @override
  _MealsPageState createState() => _MealsPageState();
}


class _MealsPageState extends State<MealsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<MealsListingBloc>(context).add(MealsFetchEvent());
    
    return Scaffold(
      body: Container(
        child: BlocBuilder<MealsListingBloc, MealsListingState>(
          builder: (BuildContext context, state) {
            if (state is MealsListingLoading) {

              return Center(child: CircularProgressIndicator( strokeWidth: 2.0));

            } else if (state is MealsListingFetched) {

              final List<Meal> items = state.meals.reversed.toList();


                return ListView(
                  children: items.map((Meal meal) => Card(child: ListTile(
                      title: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${meal.calories.toStringAsFixed(2)}kCal'),
                            DateTimeWidget(dateTime: meal.datetime)
                          ]
                      ),
                      subtitle: Text(meal.description),
                      onTap: () => MealActionsModal.showModal(context, meal)
                  ))).toList(),
                );
            }

            return Center(child: Text('Unknown state'));
          }
        )
      ),
    );
  }
}
