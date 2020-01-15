import 'package:catmanager/models/product_model.dart';

abstract class ProductListingState {}

class  ProductListingLoadingState extends ProductListingState {}

class  ProductListingFetchedState extends ProductListingState {
  ProductListingFetchedState({
    this.products,
  });
  final List<Product> products;
}

