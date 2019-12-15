import 'package:catmanager/models/custom_dish_model.dart';
import 'package:flutter/cupertino.dart';

abstract class CustomDishListingEvent {}
class CustomDishesFetchEvent extends CustomDishListingEvent {}
class CustomDishesFetchedEvent extends CustomDishListingEvent {}

class CustomDishCreatingEvent extends CustomDishListingEvent {
  CustomDishCreatingEvent(@required this.dish) : assert(dish != null);
  final CustomDish dish;
}
class CustomDishDeletingEvent extends CustomDishListingEvent {
  CustomDishDeletingEvent(@required this.dish) : assert(dish != null);
  final CustomDish dish;
}