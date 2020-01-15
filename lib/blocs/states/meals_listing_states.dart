import 'package:catmanager/models/meal_model.dart';

abstract class MealsListingState {}

class MealsListingLoading extends MealsListingState {}

class MealsListingFetched extends MealsListingState {

  MealsListingFetched({
    this.meals,
  });

  final List<Meal> meals;

  double getTotalCalories() {
    double totalCalories = 0;
    meals.forEach((meal) => totalCalories += meal.calories);
    return totalCalories;
  }

  double getTotalCaloriesEaten() {
    double totalCalories = 0;
    meals.forEach((meal) => totalCalories += (meal.isEaten ? meal.calories : 0));
    return totalCalories;
  }
}
