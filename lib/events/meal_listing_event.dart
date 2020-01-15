import 'package:catmanager/models/meal_model.dart';
import 'package:flutter/cupertino.dart';

abstract class MealsListingEvent {}

class MealsFetchEvent extends MealsListingEvent {}
class MealsFetchedEvent extends MealsListingEvent {}

class MealsResortingEvent extends MealsListingEvent {
  MealsResortingEvent(@required this.meals);
  final List<Meal> meals;
}

class MealCreatingEvent extends MealsListingEvent {
  MealCreatingEvent(@required this.meal, this.meals, this.callback) : assert(meal != null);
  final Meal meal;
  final List<Meal> meals;
  final callback;
}
class MealDeletingEvent extends MealsListingEvent {
  MealDeletingEvent(@required this.meal) : assert(meal != null);
  final Meal meal;
}