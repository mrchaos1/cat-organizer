import 'dart:async';

import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/widgets/bottom_sheet_container.dart';
import 'package:catmanager/widgets/calc_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class CreateMealWidget extends StatefulWidget {
  CreateMealWidget(this.sortOrder);
  int sortOrder;
  _CreateMealWidgetState createState() => _CreateMealWidgetState();
}

class _CreateMealWidgetState extends State<CreateMealWidget> {
  GlobalKey<FormState> _formKey;
  TextEditingController _mealController;
  double _totalCalories = 0;
  DateTime _delayed;
  String _delayedTimeFormatted;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _mealController = new TextEditingController();
  }

  @override
  void dispose() {
    _mealController.dispose();
    super.dispose();
  }

  _mealSave(int sortOrder, List<Meal> meals) {
    if (_formKey.currentState.validate()) {
      Expression exp = Parser().parse(_mealController.text);
      final double resutValue = exp.evaluate(EvaluationType.REAL, ContextModel());
      final Meal meal =  Meal(calories: resutValue, datetime: DateTime.now(), eatenDatetime: DateTime.now(), sortOrder: sortOrder);

      if (_delayed != null) {
        meal.isEaten = false;
        meal.delayed = _delayed;
      }

      _mealController.clear();
      _mealController.text = '';
      _formKey.currentState.reset();

      BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(meal, meals, () {

      }));
    }
  }

  _onControllerUpdate() {
//    yield _mealController.text == '' ? 0 : (double.parse(_mealController.text) + _totalCalories);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MealsListingBloc, MealsListingState>(
      builder: (BuildContext context, state) {
        _totalCalories = 0;
        int _sortOrder = 0;

        if (state is MealsListingLoading) {
          return Container( child: Text('Loading...'), );
        }

        if (state is MealsListingFetched) {
          state.meals.forEach((meal) => _totalCalories += meal.calories);
          _mealController.addListener(_onControllerUpdate);

          if (_delayed != null) {
            _delayedTimeFormatted = DateFormat('HH:mm yyyy, MMM dd').format(_delayed);
          }

          if (state.meals.length > 0 && state.meals.first.sortOrder != null) {
            _sortOrder = state.meals.first.sortOrder - 1;
          }

          return BottomSheetContainer(
            child: Wrap(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  decoration: new BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Consumed: ${_totalCalories.toStringAsFixed(2)} kCal', textAlign: TextAlign.center),
                    ]),
                ),
                Builder(
                  builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Color(0xFFEEEEEE),
                          child:  TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.red,
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              suffix: Text('kCal'),
                              prefix: Text('+'),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some value';
                              }
                              return null;
                            },
                            maxLines: 1,
                            controller: _mealController,
                          ),
                        ),

                        CalcKeyboardWidget(
                          controller: _mealController,
                          onPressed: () => _mealSave(_sortOrder, state.meals),
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          );
        }
      }
    );
  }
}

