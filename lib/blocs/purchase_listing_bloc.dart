import 'package:bloc/bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/blocs/states/purchase_listing_states.dart';
import 'package:catmanager/events/purchase_listing_event.dart';
import 'package:catmanager/repositories/purchase_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseListingBloc extends Bloc<PurchaseListingEvent, PurchaseListingState> {

  final _purchaseRepository = PurchaseRepository();

  @override
  PurchaseListingState get initialState => PurchaseListingLoadingState();

  @override
  Stream<PurchaseListingState> mapEventToState(PurchaseListingEvent event)  async* {
    if (event is PurchaseListingFetchingEvent) {
      yield* _reloadPurchases();
    } else if (event is PurchaseCreatingEvent) {
      await _purchaseRepository.save(event.purchase);
      yield* _reloadPurchases();
    } else if (event is MealsListingLoading) {
      yield PurchaseListingLoadingState();
      yield* _reloadPurchases();
    } else if (event is PurchaseDeletingEvent) {
      await _purchaseRepository.delete(event.purchase);
      yield* _reloadPurchases();
    }
  }

  Stream<PurchaseListingFetchedState> _reloadPurchases() async* {
    final purchases = await _purchaseRepository.getWithProducts();
//    final purchases = await _purchaseRepository.findAll();
    yield PurchaseListingFetchedState(purchases: purchases);
  }
}