import 'package:catmanager/models/product_model.dart';
import 'package:flutter/material.dart';

abstract class ProductListingEvent {}

class ProductListingFetchingEvent extends ProductListingEvent {}
class ProductListingFetchedEvent extends ProductListingEvent {}

class ProductCreatingEvent extends ProductListingEvent {
  ProductCreatingEvent(@required this.product, @required this.callback) : assert(product != null);
  final Product product;
  final Function callback;
}

class ProductCreatedEvent extends ProductListingEvent {
  ProductCreatedEvent(@required this.product) : assert(product != null);
  final Product product;
}

class ProductDeletingEvent extends ProductListingEvent {
  ProductDeletingEvent(@required this.product) : assert(product != null);
  final Product product;
}