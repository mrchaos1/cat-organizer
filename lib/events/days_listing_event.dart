import 'package:catmanager/models/day_model.dart';
import 'package:flutter/cupertino.dart';

abstract class DaysListingEvent {}

class DaysFetchEvent extends DaysListingEvent {}
class MealsFetchedEvent extends DaysListingEvent {}

class DayCreatingEvent extends DaysListingEvent {
  DayCreatingEvent(@required this.day, @required this.callback) : assert(day != null);
  final Day day;
  final Function callback;
}

class DayDeletingEvent extends DaysListingEvent {
  DayDeletingEvent(@required this.day) : assert(day != null);
  final Day day;
}