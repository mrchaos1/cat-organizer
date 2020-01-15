import 'package:bloc/bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/blocs/states/product_listing_states.dart';
import 'package:catmanager/events/product_listing_event.dart';
import 'package:catmanager/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListingBloc extends Bloc<ProductListingEvent, ProductListingState> {

  final _productRepository = ProductRepository();

  @override
  ProductListingState get initialState => ProductListingLoadingState();

  @override
  Stream<ProductListingState> mapEventToState(ProductListingEvent event)  async* {
    if (event is ProductListingFetchingEvent) {
      yield* _reloadProducts();
    } else if (event is ProductCreatingEvent) {
      await _productRepository.save(event.product);
      event.callback();
      yield* _reloadProducts();
    } else if (event is MealsListingLoading) {
      yield ProductListingLoadingState();
      yield* _reloadProducts();
    } else if (event is ProductDeletingEvent) {
      await _productRepository.delete(event.product);
      yield* _reloadProducts();
    }
  }

  Stream<ProductListingFetchedState> _reloadProducts() async* {
    final products = await _productRepository.findAll();
    yield ProductListingFetchedState(products: products);
  }
}