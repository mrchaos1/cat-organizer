import 'package:catmanager/models/day_model.dart';

abstract class DaysListingState {}

class DaysListingLoading extends DaysListingState {}

class DaysListingFetched extends DaysListingState {

  DaysListingFetched({
    this.days,
  });

  final List<Day> days;
}

