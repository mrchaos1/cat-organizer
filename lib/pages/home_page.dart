import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/states/custom_dish_listing_states.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/modals/custom_dish_actions_modal.dart';
import 'package:catmanager/modals/custom_dish_gobble_up_modal.dart';
import 'package:catmanager/modals/finish_day_modal.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    BlocProvider.of<MealsListingBloc>(context).add(MealsFetchEvent());
    BlocProvider.of<CustomDishListingBloc>(context).add(CustomDishesFetchEvent());

    return Scaffold(
      body: Container(child: BlocBuilder<MealsListingBloc, MealsListingState>(
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    child: BlocBuilder<MealsListingBloc, MealsListingState>(
                      builder: (BuildContext context, state) {
                        if (state is MealsListingLoading) {

                          return Center(child: CircularProgressIndicator( strokeWidth: 2.0));

                        } else if (state is MealsListingFetched) {

                          return ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            title: Text('${state.getTotalCaloriesEaten().toStringAsFixed(2)}kCal'),
                            trailing: RaisedButton(
                              child: Text('Day finish'),
                              onPressed: () => FinishDayModal.showModal(context, state)
                            ),
                          );

                        }
                        return Center(child: Text('Unknown state'));
                      }
                    )
                  ),
                  Container(
                    child: BlocBuilder<CustomDishListingBloc, CustomDishListingState>(
                      builder: (BuildContext context, state) {
                        if (state is CustomDishListingLoadingState) {
                          return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
                        } else if (state is CustomDishListingFetchedState) {
                          return Column(

                            children: state.dishes.reversed.toList().map((CustomDish dish) => Card(
                              color: Color(0xFFFFF3E0),
                              child: ListTile(
                                  contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                title: Text(dish.title),
                                trailing:  RaisedButton(
                                    child: Text('To gobble up'),
                                    onPressed: () => CustomDishGobbleUpModal.showModal(context, dish)
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('${dish.getCalorieContent().toStringAsFixed(2)}kCal/100g'),
                                    Text('Total calories: ${dish.calories.toString()}kCal/100g'),
                                    Text('Result weight ${dish.getFinalWeight()}g'),
                                    Text('Pan weight ${dish.panWeight}g'),
                                    Text('With pan weight ${dish.weight}g'),
                                  ],
                                ),
                                onTap: () => CustomDishActionsModal.showModal(context, dish)


                            ))).toList(),
                          );
                        }
                        return Center(child: Text('Unknown state'));
                      }
                    ),
                  ),
                ]
              )
            );
          },
        ),
      ),
    );
  }
}
