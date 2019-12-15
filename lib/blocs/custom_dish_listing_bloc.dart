import 'package:bloc/bloc.dart';
import 'package:catmanager/blocs/states/custom_dish_listing_states.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/repositories/distom_dish_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/repositories/meal_repository.dart';

class CustomDishListingBloc extends Bloc<CustomDishListingEvent, CustomDishListingState> {

  final _customDishRepository = CustomDishRepository();

  @override
  CustomDishListingState get initialState => CustomDishListingLoadingState();

  @override
  Stream<CustomDishListingState> mapEventToState(CustomDishListingEvent event)  async* {
    if (event is CustomDishesFetchEvent) {
      yield* _reloadDishes();
    } else if (event is CustomDishCreatingEvent) {
      var dish = await _customDishRepository.save(event.dish);
      yield* _reloadDishes();
     }else if (event is CustomDishDeletingEvent) {
      await _customDishRepository.delete(event.dish);
      yield* _reloadDishes();
    }

//    else if (event is MealsListingLoading) {
//      yield MealsListingLoading();
//      yield* _reloadDishes();

  }

  Stream<CustomDishListingFetchedState> _reloadDishes() async* {
    final dishes = await _customDishRepository.findAll();
    yield CustomDishListingFetchedState (dishes: dishes);
  }
}