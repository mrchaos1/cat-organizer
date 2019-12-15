import 'package:catmanager/models/meal_model.dart';
import 'package:flutter/cupertino.dart';

abstract class MealsListingEvent {}

class MealsFetchEvent extends MealsListingEvent {}
class MealsFetchedEvent extends MealsListingEvent {}


class MealCreatingEvent extends MealsListingEvent {
  MealCreatingEvent(@required this.meal) : assert(meal != null);
  final Meal meal;
}
class MealDeletingEvent extends MealsListingEvent {
  MealDeletingEvent(@required this.meal) : assert(meal != null);
  final Meal meal;
}