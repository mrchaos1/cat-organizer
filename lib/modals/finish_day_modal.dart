import 'package:catmanager/blocs/days_listring_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/days_listing_event.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/day_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class FinishDayModal {

  static Future showModal(BuildContext context, List<Meal> meals) async {

    final DateTime now = DateTime.now();
    double totalCalories = 0;
    meals.forEach((meal) => totalCalories += meal.calories);

    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(now.year, now.month - 1, now.day),
        maxTime: DateTime(now.year, now.month + 1, now.day),
        onChanged: (DateTime dateTime) {
        },
        onConfirm: (DateTime dateTime) {
          final Day day = Day(calories: totalCalories, startDatetime: dateTime);
          BlocProvider.of<DaysListingBloc>(context).add(DayCreatingEvent(day, () {
            BlocProvider.of<MealsListingBloc>(context).add(MealsFetchEvent());
          }));
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en
    );
  }
}