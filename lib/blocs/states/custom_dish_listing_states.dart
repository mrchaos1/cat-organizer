import 'package:catmanager/models/custom_dish_model.dart';

abstract class CustomDishListingState {}

class CustomDishListingLoadingState extends CustomDishListingState {}

class CustomDishListingFetchedState extends CustomDishListingState {
  CustomDishListingFetchedState({
    this.dishes,
  });
  final List<CustomDish> dishes;
}

