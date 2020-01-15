import 'package:catmanager/models/purchase_model.dart';
import 'package:flutter/material.dart';

abstract class PurchaseListingEvent {}

class PurchaseListingFetchingEvent extends PurchaseListingEvent {}
class PurchaseListingFetchedEvent extends PurchaseListingEvent {}

class PurchaseCreatingEvent extends PurchaseListingEvent {
  PurchaseCreatingEvent(@required this.purchase) : assert(purchase != null);
  final Purchase purchase;
}

class PurchaseDeletingEvent extends PurchaseListingEvent {
  PurchaseDeletingEvent(@required this.purchase) : assert(purchase != null);
  final Purchase purchase;
}