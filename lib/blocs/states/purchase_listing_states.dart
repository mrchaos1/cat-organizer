import 'package:catmanager/models/purchase_model.dart';

abstract class PurchaseListingState {}

class  PurchaseListingLoadingState extends PurchaseListingState {}

class  PurchaseListingFetchedState extends PurchaseListingState {
  PurchaseListingFetchedState({
    this.purchases,
  });
  final List<Purchase> purchases;
}
