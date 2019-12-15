import 'package:bloc/bloc.dart';
import 'package:catmanager/blocs/states/days_listing_states.dart';
import 'package:catmanager/events/days_listing_event.dart';
import 'package:catmanager/repositories/day_repository.dart';
import 'package:catmanager/repositories/meal_repository.dart';

class DaysListingBloc extends Bloc<DaysListingEvent, DaysListingState> {

  final _dayRepository = DayRepository();
  final _mealRepository = MealRepository();

  @override
  DaysListingState get initialState => DaysListingLoading();

  @override
  Stream<DaysListingState> mapEventToState(DaysListingEvent event)  async* {

    if (event is DaysFetchEvent) {
      yield* _reloadDays();
    } else if (event is DayCreatingEvent) {
      await _dayRepository.save(event.day);
      await _mealRepository.deleteAll();
      event.callback();
      yield* _reloadDays();
    } else if (event is DaysListingLoading) {
      yield DaysListingLoading();
      yield* _reloadDays();
    } else if (event is DayDeletingEvent) {
      await _dayRepository.delete(event.day);
      yield* _reloadDays();
    }
  }

  Stream<DaysListingFetched> _reloadDays() async* {
    final days = await _dayRepository.findAll();
    yield DaysListingFetched(days: days);
  }
}