import 'package:bloc/bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/repositories/meal_repository.dart';

class MealsListingBloc extends Bloc<MealsListingEvent, MealsListingState> {

  final _mealRepository = MealRepository();

  @override
  MealsListingState get initialState => MealsListingLoading();

  @override
  Stream<MealsListingState> mapEventToState(MealsListingEvent event)  async* {
    if (event is MealsFetchEvent) {
      yield* _reloadMeals();
    } else if (event is MealCreatingEvent) {
      await _mealRepository.save(event.meal);
      yield* _reloadMeals();
    } else if (event is MealsListingLoading) {
      yield MealsListingLoading();
      yield* _reloadMeals();
    } else if (event is MealDeletingEvent) {
      await _mealRepository.delete(event.meal);
      yield* _reloadMeals();
    }
  }

  Stream<MealsListingFetched> _reloadMeals() async* {
    final meals = await _mealRepository.findAll();
    yield MealsListingFetched(meals: meals);
  }
}